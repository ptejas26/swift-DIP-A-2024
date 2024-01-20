//
//  LaunchDetailsViewController.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 16/06/21.
//

import UIKit
import AppCenterAnalytics
import AppCenterCrashes

public final class LaunchDetailsViewController: UIViewController {


	@IBOutlet private weak var launchImgView: UIImageView!
	@IBOutlet private weak var launchNameLabel: UILabel!
	@IBOutlet private weak var launchDateTimeLabel: UILabel!
	@IBOutlet private weak var launchFlightNoLabel: UILabel!
	@IBOutlet private weak var launchPayloadCountLabel: UILabel!
	@IBOutlet private weak var makeFavBtn: UIButton!
	@IBOutlet private weak var tableView: UITableView! {
		didSet {
			tableView.register(nibName: "PayloadCell", with: Constant.cellPayloadIdentifer)
			tableView.dataSource = self
			tableView.delegate = self
			tableView.separatorStyle = .none
			tableView.keyboardDismissMode = .interactive
		}
	}

	private struct Constant {
		static let cellPayloadIdentifer =  "payloadCell"
		static let title = "Launch Details"
	}
	public var viewModel: DetailViewModel = DetailViewModel()
	
    public override func viewDidLoad() {
        super.viewDidLoad()
		title = Constant.title
		viewModel.delegate = self
		setupUI()
		setData()
        Analytics.trackEvent("\(Constant.title) - viewDidLoad")
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Crashes.hasCrashedInLastSession {
            let alert = UIAlertController(title: "Opps", message: "We appologies for the crash in last session", preferredStyle: .alert)
            self.present(alert, animated: true)
        }
    }
    

	public override func viewWillAppear(_ animated: Bool) {
		tableView.reloadData()
	}

}

extension LaunchDetailsViewController {

	private func setupUI() {
		SpinnerManager.showLoader(with: launchImgView)
	}

	private func setImage(sender: UIButton, state: Bool) {
		if state {
			sender.setImage(UIImage(named: "selected"), for: .normal)
		} else {
			sender.setImage(UIImage(named: "unselected"), for: .normal)
		}
	}

	private func setData() {

		launchNameLabel.text = "Launch Name:\(viewModel.selectedLaunch.returnLaunchName())"
		launchDateTimeLabel.text = "Launch Date/Time: \(viewModel.selectedLaunch.returnLaunchDateTime())"
		launchFlightNoLabel.text = "Flight No: \(viewModel.selectedLaunch.returnLaunchFlightNo())"
		launchPayloadCountLabel.text = "Count of Payload: \(viewModel.selectedLaunch.returnCountOfPayload())"

		//expandPayloadBtn.isHidden = !launchVM.returnShowPayload()
		setImage(sender: makeFavBtn, state: viewModel.selectedLaunch.returnFavoriteLaunch())
		let link = viewModel.selectedLaunch.returnLaunchImageLinkForDetails()
		if link.isEmpty {
			launchImgView.image = UIImage(named: "placeholderImage")
			return
		}
		launchImgView.downloadImage(imageURL: link) { [weak self] (uiimage, error) in

			DispatchQueue.main.async { [weak self] in
				SpinnerManager.hideLoader()
				if error == nil {
					self?.launchImgView.image = uiimage
				} else {
					self?.launchImgView.image = UIImage(named: "placeholderImage")
				}
			}
		}
	}

	private func toggleFavImage(sender: UIButton) -> Bool {
		guard let img = sender.image(for: .normal) else {return false}
		if img == UIImage(named: "selected") {
			setImage(sender: sender, state: false)
			return false
		} else {
			setImage(sender: sender, state: true)
			return true
		}
	}

}

extension LaunchDetailsViewController: UITableViewDataSource, UITableViewDelegate {

	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.returnPayloadCount()
	}

	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let payloadCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellPayloadIdentifer, for: indexPath) as? PayloadCell else { return UITableViewCell() }

		let data = viewModel.returnPayloadData(row: indexPath.row)
			payloadCell.setData(name: data.name, type: data.type)
			return payloadCell
	}
}

extension LaunchDetailsViewController {

	@IBAction private func favButtonAction(_ sender: UIButton) {
		let state = toggleFavImage(sender: sender)
        let favString = state ? "Favorite" : "Unfavorite"
        Analytics.trackEvent("\(Constant.title) - \(favString) - \(sender.tag)")
		viewModel.selectedLaunch.setFavoriteLaunch(status: state, launchID: viewModel.selectedLaunch.returnLaunchID())
	}
	
}

extension LaunchDetailsViewController: DetailViewModelProtocol {

	public func showAlertViewWhenError(title: String, error: String) {
		showAlertViewWhenError(title: title, error: error)
	}


	public func reloadTableView() {
		tableView.reloadData()
	}

}
