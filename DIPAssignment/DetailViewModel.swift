//
//  DetailViewModel.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 21/06/21.
//

import Foundation

public protocol DetailsLoadable: AnyObject  {
	func returnPayloadData(row: Int) -> (name: String, type: String)
	func payloadOperation()
	func returnPayloadCount() -> Int
}


public protocol DetailViewModelProtocol: AnyObject {
	func reloadTableView()
	func showAlertViewWhenError(title: String, error: String)
}

public final class DetailViewModel {
	public var selectedLaunch: ListingViewModel!
	public var launch: Launch!
	public var payloadURLs = [String]() {
		didSet {
			if payloadURLs.count > 0 {
				payloadOperation()
			}
		}
	}
	public var payloadData = [(name:String, type: String)]()
	public weak var delegate: DetailViewModelProtocol?
	
	private var operationsQueue = OperationQueue()
	
	public func returnPayloadCount() -> Int {
		return payloadURLs.count
	}

	public func returnPayloadData(row: Int) -> (name: String, type: String) {
		if payloadData.count > 0 {
			return payloadData[row]
		}
		return (name: "Loading...", type: "Loading...")
	}

	public func payloadOperation() {
		
		if payloadURLs.isEmpty {return}
		
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
		
		for item in payloadURLs {
			let url = Constant.API_URLS.get_payloadperlaunch + "\(item)"
			opt = Operations(launchID: selectedLaunch.returnLaunchID(), url: url, delegate: self)
			operationsQueue.addOperation(opt)
		}
	}
}

extension DetailViewModel: OperationProtocol {
	
	func operationCanceled(string: String?) {
		
	}
	
	func operationCompleted(launchID: String, response: Any, message: String?) {
		payloadData.append(response as! (name: String, type: String))
		print(response)
		if payloadData.count == payloadURLs.count {
			delegate?.reloadTableView()
		}
	}
	
	func operationError(error: Error?) {
		delegate?.showAlertViewWhenError(title: "Alert", error: error?.localizedDescription ?? "Error performing payload operation!")
	}
	
}
