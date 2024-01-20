//
//  LaunchViewController.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import UIKit
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

public final class LaunchViewController: UIViewController {

	private struct Constant {
		static let cellIdentifer =  "launchCell"
		static let cellPayloadIdentifer =  "payloadCell"
		static let title = "Launches"
	}

	private var viewModel = ListingViewModel()
	@IBOutlet private weak var payloadFilterSwitch: UISwitch!
	@IBOutlet private weak var switchView: UIView!
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			tableView.register(nibName: "LaunchCell", with: Constant.cellIdentifer)
			tableView.register(nibName: "PayloadCell", with: Constant.cellPayloadIdentifer)
			tableView.dataSource = self
			tableView.delegate = self
			tableView.separatorStyle = .none
			tableView.keyboardDismissMode = .interactive
			tableView.contentInset.bottom = CGFloat(100)
		}
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		SpinnerManager.showLoader(with: self.view)
		viewModel.getListingData()
		setupUI()
        setupAppCenter()
		viewModel.delegate = self
        Analytics.trackEvent("\(Constant.title) - viewDidLoad", withProperties: ["fileName" : "LaunchViewController"], flags: .normal)
	}
    func setupAppCenter() {
        AppCenter.start(services: [
            Crashes.self
        ])
    }
}

extension LaunchViewController {

	private func setupUI() {
		switchView.addBorder()
		switchView.dropCorner()
		setPayloadState()
        
        
	}

	private func setPayloadState() {
		let state = viewModel.getFilterStateFromDatebaseAndPerformFilter()
		payloadFilterSwitch.setOn(state, animated: true)
	}

	public func navigateToDetailsView(section: Int) {
		guard let detailsView = ViewUtility.getLaunchDetailsController() else {return}
		detailsView.viewModel.selectedLaunch = viewModel.returnLaunchData(section: section)
		detailsView.viewModel.payloadURLs = viewModel.returnPayloadURLs(section: section)
		navigationController?.pushViewController(detailsView, animated: true)
	}

}

extension LaunchViewController: UITableViewDataSource {

	public func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.returnLaunchCount()
	}

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		if viewModel.getShowPayload(section: section) {
			return viewModel.returnPayloadCount(for: section) + 1
		}
		return 1
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let launchCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifer, for: indexPath) as? LaunchCell else { return UITableViewCell() }
		guard let payloadCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellPayloadIdentifer, for: indexPath) as? PayloadCell else { return UITableViewCell() }


		if indexPath.row == 0 {
			guard let launchVM = viewModel.returnLaunchData(section: indexPath.section) else { return UITableViewCell() }
			launchCell.setData(launchVM: launchVM, indexPath: indexPath)
			launchCell.delegate = self
			return launchCell
		} else {
			let data = viewModel.returnPayloadData(for: indexPath)
			payloadCell.setData(name: data.name, type: data.type)
			return payloadCell
		}
	}

}

extension LaunchViewController: UITableViewDelegate {

	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Constant.title
        Analytics.trackEvent("\(Constant.title) - didSelectRowAt")
        navigateToDetailsView(section: indexPath.section)
	}
}


extension LaunchViewController: ListingViewModelProtocol {

	public func removeLoader() {
		SpinnerManager.hideLoader()
	}

	public func reloadSection(section: IndexSet) {
		tableView.reloadSections(section, with: .none)
	}

	public func showAlertViewWhenError(title: String, error: String) {
		SpinnerManager.hideLoader()
		showAlertView(title: title, message: error, showRetry: true) { [weak self] (action) in
			self?.viewModel.getListingData()
		}
	}

	public func reloadTableView() {
		SpinnerManager.hideLoader()
		tableView.reloadData()
	}

}


extension LaunchViewController: LaunchCellProtocol {

	public func setLaunchAsFavorite(indexPath: IndexPath, favState: Bool) {
        let favString = favState ? "Favorite" : "Unfavorite"
        Analytics.trackEvent("\(Constant.title) - \(favString) - \(indexPath.row)")
		viewModel.setFavoriteLaunch(status: favState, for: indexPath.section)
	}

	public func expandCellToShowPayload(indexPath: IndexPath, sender: UIButton) {
		if sender.transform != .identity  {
			SpinnerManager.showLoader(with: self.view)
		}
		viewModel.setShowPayload(section: indexPath.section)
	}

}

extension LaunchViewController {

	@IBAction private func payloadSwitchChange(_ sender: UISwitch) {
		viewModel.setFilterStateToDatabaseAndPerformFilter(state: sender.isOn)
        Crashes.generateTestCrash()
	}
}
