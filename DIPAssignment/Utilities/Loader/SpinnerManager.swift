//
//  SpinnerView.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 21/06/21.
//

import UIKit

let TimerConstant = 1.8
let DefaultRect = CGRect(x: 0, y: 0, width: 70, height: 70)
let DefaultColor = UIColor.white

class SpinnerManager {

	fileprivate var renderingView :UIView? = nil
	fileprivate var array : [UIImage] = []
	fileprivate var defaultRect : CGRect = DefaultRect
	fileprivate let spinnerView : Spinnerview?
	fileprivate let imgView = UIImageView()
	fileprivate static var spinnerManager :SpinnerManager?
	fileprivate var animatingDuration : Int = 2
	fileprivate var backgroundBlurButton : UIButton = UIButton()
	fileprivate var customColor : UIColor = UIColor(red: 0.094, green: 0.681, blue: 0.295, alpha: 1.0)
	fileprivate var enteredBackground : Bool = false
	fileprivate var timer : Timer?
	fileprivate var colorArray : [UIColor] = [UIColor(red: 0.076, green: 0.455, blue: 0.723, alpha: 1.0),
											  UIColor(red: 0.094, green: 0.681, blue: 0.295, alpha: 1.0),
											  UIColor(red: 1.0, green: 0.791, blue: 0.021, alpha: 1.0)]

	init(with view:UIView){
		imgView.image = UIImage(named: "dip_logo")
		spinnerView = Spinnerview(frame: defaultRect)
		spinnerView?.customColor = DefaultColor
		renderingView = view
		imgView.frame = spinnerView!.bounds
		imgView.layer.cornerRadius = imgView.bounds.width / 2
		imgView.clipsToBounds = true
		spinnerView!.frame = CGRect(x: 0, y: 0, width: defaultRect.width+20, height:defaultRect.height+20)
		imgView.center = spinnerView!.center
		spinnerView?.center = renderingView!.center
		setupBackButton()
		self.spinnerView?.addSubview(imgView)
		self.renderingView?.addSubview(spinnerView!)
		NotificationCenter.default.addObserver(self, selector: #selector(appEnteredBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
	}

	@objc private func appEnteredBackground() {
		enteredBackground = true
	}

	@objc private func appEnteredForeground() {
		if enteredBackground {
			self.spinnerView?.layoutSubviews()
		}else{
		}
	}

	func setupBackButton() {
		backgroundBlurButton.frame = self.renderingView!.bounds
		backgroundBlurButton.backgroundColor = UIColor.black
		backgroundBlurButton.alpha = 0.35
		backgroundBlurButton.center = renderingView!.center
		self.renderingView?.addSubview(backgroundBlurButton)
	}

	func animateImageView() {
		imgView.animationDuration = TimeInterval(animatingDuration)
		imgView.animationImages = array
		imgView.startAnimating()
	}


	private func startAnimation() {
		renderingView?.isUserInteractionEnabled = false
		spinnerView?.animating = true
	}

	private func stopAnimation() {
		imgView.stopAnimating()
		renderingView?.isUserInteractionEnabled = true
		imgView.image = UIImage(named: "Loader-Done")
		spinnerView?.animating = false
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
			self.animateRemoval()
		}
	}
	private func animateRemoval() {

		UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
			if self.spinnerView != nil {
				self.spinnerView!.alpha = 0.2
				self.backgroundBlurButton.alpha = 0.2
			}
		}, completion: { (true) in
			self.backgroundBlurButton.removeFromSuperview()
			self.spinnerView!.removeFromSuperview()
		})
	}

	static func showLoader(with view: UIView) {
		spinnerManager = SpinnerManager(with: view)
		self.spinnerManager?.startAnimation()

	}
	static func hideLoader(){
		spinnerManager?.stopAnimation()
	}
}
