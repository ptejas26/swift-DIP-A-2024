//
//  LaunchCell.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import UIKit

public protocol LaunchCellProtocol: AnyObject {
	func setLaunchAsFavorite(indexPath: IndexPath, favState: Bool)
	func expandCellToShowPayload(indexPath: IndexPath, sender: UIButton)
}



public final class LaunchCell: UITableViewCell {
	
	@IBOutlet private weak var launchImgView: UIImageView!
	@IBOutlet private weak var launchNameLabel: UILabel!
	@IBOutlet private weak var launchDateTimeLabel: UILabel!
	@IBOutlet private weak var launchFlightNoLabel: UILabel!
	@IBOutlet private weak var launchPayloadCountLabel: UILabel!
	@IBOutlet private weak var makeFavBtn: UIButton!
	@IBOutlet private weak var expandPayloadBtn: UIButton!
	@IBOutlet private weak var parentView: UIView!
	
	weak var delegate: LaunchCellProtocol? = nil
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		setupCell()
	}
	
	public override func prepareForReuse() {
		super.prepareForReuse()
        launchNameLabel.text = nil 
		launchImgView.image = nil
	}
	
	private func setupCell() {
		launchImgView.addBorder()
		launchImgView.dropCorner()
		parentView.addBorder()
		parentView.dropCorner()
		selectionStyle = .none
	}
	
	public func setData(launchVM: ListingViewModel, indexPath: IndexPath) {
		
		launchNameLabel.text = "Launch Name:\(launchVM.returnLaunchName())"
		launchDateTimeLabel.text = "Launch Date/Time: \(launchVM.returnLaunchDateTime())"
		launchFlightNoLabel.text = "Flight No: \(launchVM.returnLaunchFlightNo())"
		launchPayloadCountLabel.text = "Count of Payload: \(launchVM.returnCountOfPayload())"
		makeFavBtn.tag = indexPath.section
		makeFavBtn.addTarget(self, action: #selector(favButtonAction(sender:)), for: .touchUpInside)
		expandPayloadBtn.tag = indexPath.section
		expandPayloadBtn.addTarget(self, action: #selector(expandButtonAction(sender:)), for: .touchUpInside)
		
		setImage(sender: makeFavBtn, state: launchVM.returnFavoriteLaunch())
		let link = launchVM.returnLaunchImageLink()
		if link.isEmpty {
			launchImgView.image = UIImage(named: "placeholderImage")
			return
		}
		launchImgView.downloadImage(imageURL: link) { [weak self] (uiimage, error) in
			
			
			DispatchQueue.main.async { [weak self] in
				if error == nil {
					self?.launchImgView.image = uiimage
				} else {
					self?.launchImgView.image = UIImage(named: "placeholderImage")
				}
			}
		}
	}
}


extension LaunchCell {
	
	@objc func favButtonAction(sender: UIButton) {
		let status = toggleFavImage(sender: sender)
		delegate?.setLaunchAsFavorite(indexPath: IndexPath(row: 0, section: sender.tag), favState: status)
	}
	
	@objc func expandButtonAction(sender: UIButton) {
		animateExpandButton(sender: sender)
		delegate?.expandCellToShowPayload(indexPath: IndexPath(row: 0, section: sender.tag), sender: sender)
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
	
	private func setImage(sender: UIButton, state: Bool) {
		if state {
			sender.setImage(UIImage(named: "selected"), for: .normal)
		} else {
			sender.setImage(UIImage(named: "unselected"), for: .normal)
		}
	}
	
	
	private func animateExpandButton(sender: UIButton) {
		if sender.transform == .identity {
			UIView.animate(withDuration: 0.4) {
				sender.transform = CGAffineTransform.init(rotationAngle: (180 * .pi) / 180)
			}
		} else {
			UIView.animate(withDuration: 0.4) {
				sender.transform = .identity
			}
		}
	}
	
}
