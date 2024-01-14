//
//  ListingViewModel.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import Foundation
import RealmSwift

public protocol ListingLoadable: AnyObject {
	func getListingData()
	func returnLaunchCount() -> Int
	func returnLaunchData(section: Int) -> ListingViewModel?
	func returnLaunchID() -> String
	func returnLaunchName() -> String
	func returnLaunchDateTime() -> String
	func returnLaunchFlightNo() -> String
	func returnCountOfPayload() -> String
	func returnLaunchImageLink() -> String
	func returnLaunchImageLinkForDetails() -> String
	func returnFavoriteLaunch() -> Bool
	func setFavoriteLaunch(status: Bool, for section: Int)
	func setFavoriteLaunch(status: Bool,launchID: String)
	func returnPayloadCount(for section: Int) -> Int
	func returnPayloadData(for indexPath: IndexPath) -> (name:String, type: String)
	func returnPayloadURLs(section: Int) -> [String]
	func returnShowPayload() -> Bool
	func getShowPayload(section: Int)  -> Bool 
	func setShowPayload(section: Int)
	func getFilterStateFromDatebaseAndPerformFilter() -> Bool
	func setFilterStateToDatabaseAndPerformFilter(state: Bool)
}

public protocol ListingViewModelProtocol: AnyObject {
	func reloadTableView()
	func showAlertViewWhenError(title: String, error: String)
	func reloadSection(section: IndexSet)
}

public final class ListingViewModel: ListingLoadable {

	private var launch: Launch?
	private var launchArray: [Launch] = []
	private var launchArrayFilterCopy: [Launch] = []
	private var operationsQueue = OperationQueue()
	public var delegate: ListingViewModelProtocol?

	public init() {}
	public init(launch : Launch) {
		self.launch = launch
	}

	public final func getListingData() {
		ServiceManager.getMethod([Launch].self) { (result) in

			DispatchQueue.main.async { [weak self] in
				switch result {
				case .failure(let error):
					self?.delegate?.showAlertViewWhenError(title: "Error", error: error.localizedDescription)
				case .success(let response):
					self?.launchArray = []
					let arrList = List<LaunchDBModel>()
					for item in response {
						let model = LaunchDBModel(launchID: item.id ?? "", isFavorite: false, showPayload: (item.payloads?.count ?? 0) > 0 ? true : false)
						arrList.append(model)
						self?.launchArray.append(item)
					}
					self?.launchArrayFilterCopy = self?.launchArray ?? []
					let _ = self?.getFilterStateFromDatebaseAndPerformFilter() ?? false
					let listLaunch = LaunchListDBModel(list: arrList)
					if DatabaseManager.sharedInstance.getAllLaunches().count == 0 {
						DatabaseManager.sharedInstance.setLaunchData(model: listLaunch)
					}
					self?.delegate?.reloadTableView()
				}
			}
		}
	}

}

// MARK: -- Launch Related --
extension ListingViewModel {

	public func returnLaunchCount() -> Int {
		return launchArray.count
	}

	public func returnLaunchData(section: Int) -> ListingViewModel? {
		guard !launchArray.isEmpty else { return nil}
		return ListingViewModel(launch: launchArray[section])
	}

	public func returnLaunchID() -> String {
		return launch?.id ?? ""
	}

	public func returnLaunchName() -> String {
		return launch?.name ?? ""
	}

	public func returnLaunchDateTime() -> String {
		return "\(Utilities.convertTimestampToDate(ts: Double(launch?.dateUnix ?? 1222643700)))"
	}

	public func returnLaunchFlightNo() -> String {
		return "\(launch?.flightNumber ?? 0)"
	}

	public func returnCountOfPayload() -> String {
		return "\(launch?.payloads?.count ?? 0)"
	}

	public func returnLaunchImageLink() -> String {
		return "\(launch?.links?.patch?.small ?? "")"
	}

	public func returnLaunchImageLinkForDetails() -> String {
		return "\(launch?.links?.patch?.large ?? "")"
	}

	public func returnFavoriteLaunch() -> Bool {
		let launchID = launch?.id ?? ""
		return DatabaseManager.sharedInstance.getLaunchFavorite(for: launchID)
	}

	public func setFavoriteLaunch(status: Bool, for section: Int) {
		setFavoriteLaunch(status: status, launchID: launchArray[section].id ?? "")
	}

	public func setFavoriteLaunch(status: Bool,launchID: String) {
		DatabaseManager.sharedInstance.setLaunchAsFavorite(for: launchID, state: status)
		delegate?.reloadTableView()
	}

}

// MARK: -- Payload Related --
extension ListingViewModel {

	public func returnPayloadCount(for section: Int) -> Int {
		guard !launchArray.isEmpty else {return 0}
		return launchArray[section].payloads?.count ?? 0
	}

	public func returnPayloadData(for indexPath: IndexPath) -> (name:String, type: String) {
		guard !launchArray.isEmpty, !launchArray[indexPath.section].payload.isEmpty else {return (name:"Loading...", type: "Loading...")}
		return launchArray[indexPath.section].payload[indexPath.row-1]
	}

	public func returnPayloadURLs(section: Int) -> [String] {
		return launchArray[section].payloads ?? []
	}

	public func returnShowPayload() -> Bool {
		return launch?.showPayload ?? false
	}

	public func getShowPayload(section: Int) -> Bool {
		return launchArray[section].showPayload
	}

	public func setShowPayload(section: Int) {
		launchArray[section].showPayload = !launchArray[section].showPayload

		//Avoid making API call if the data already exisit
		if launchArray[section].payload.count > 0 {
			delegate?.reloadTableView()
			return
		}

		var opt: Operations!
		if operationsQueue != nil {
			operationsQueue.cancelAllOperations()
			for item in operationsQueue.operations {
				let op = item as Operation
				op.cancel()
			}
		} else {
			operationsQueue = OperationQueue()
		}

		if launchArray[section].showPayload == true {

			for item in launchArray[section].payloads ?? [] {
				let url = Constant.API_URLS.get_payloadperlaunch + "\(item)"
				opt = Operations(launchID: launchArray[section].id ?? "", url: url, delegate: self)
				operationsQueue.addOperation(opt)
			}
		}
	}

	public func getFilterStateFromDatebaseAndPerformFilter() -> Bool {
		let state = DatabaseManager.sharedInstance.getPayloadFilterState()
		filterAccordingToPayload(state: state)
		return state
	}

	public func setFilterStateToDatabaseAndPerformFilter(state: Bool) {
		DatabaseManager.sharedInstance.setPayloadFilterState(state: state)
		filterAccordingToPayload(state: state)
	}
}

// MARK: -- Filter logic --
extension ListingViewModel {

	private func filterAccordingToPayload(state: Bool) {

		if state {
			launchArray = launchArray.filter({ $0.payloads?.count ?? 0 > 0 })
		} else {
			launchArray = launchArrayFilterCopy
		}
		delegate?.reloadTableView()
	}

	public func filterAccordingToPayload(launch: Launch) -> Bool {
		return  launch.payloads?.count ?? 0 > 0 ? true : false
	}
	
}

// MARK: -- ListingViewModel Delegate --
extension ListingViewModel: OperationProtocol {

	func operationCompleted(launchID: String, response: Any, message: String?) {
		for i in 0..<launchArray.count where launchArray[i].id == launchID {
			launchArray[i].payload.append(response as! (name: String, type: String))
		}

		let launchObj = launchArray.filter({ $0.id == launchID }).first

		if launchObj?.payload.count == launchObj?.payloads?.count {

			if launchObj?.payload.count ?? 0 == 0  {
				delegate?.showAlertViewWhenError(title: "Alert", error: "No payloads are available for this Launch - \(launchID)")
			}

			delegate?.reloadTableView()
		}
	}

	func operationCanceled(string: String?) {

	}

	func operationError(error: Error?) {
		delegate?.showAlertViewWhenError(title: "Error", error: error.debugDescription)
	}

}
