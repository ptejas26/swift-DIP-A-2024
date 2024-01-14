//
//  Extensions.swift
//  PayPayAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import UIKit

extension UITableView {

	func register(nibName: String, with cellIdentifier: String) {
		let nib = UINib(nibName: nibName, bundle: nil)
		self.register(nib, forCellReuseIdentifier: cellIdentifier)
	}

}

extension UIView {

	func addBorder(width: CGFloat = 1.0, color: UIColor = .lightGray) {
		layer.borderWidth = width
		layer.borderColor = color.cgColor
	}

	func dropCorner(radius: CGFloat = 5.0) {
		layer.cornerRadius = radius
	}
	
}


extension Double {

	func roundUptoTwoDecimal() -> Double {
		return (((self) * 100).rounded() / 100)
	}

}

extension UIViewController {

	func showAlertView(title: String = "Alert", message: String = "Message", showRetry: Bool = false, completionHandler: ((UIAlertAction) -> Void)?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
		if showRetry {
			alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: completionHandler))
		}
		present(alert, animated: true, completion: nil)

	}
}
