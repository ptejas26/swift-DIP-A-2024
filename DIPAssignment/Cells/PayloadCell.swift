//
//  PayloadCell.swift
//  DIPAssignment
//
//  Created by Tejas Patelia on 15/06/21.
//

import UIKit

public final class PayloadCell: UITableViewCell {

	@IBOutlet private weak var payloadName: UILabel!
	@IBOutlet private weak var payloadType: UILabel!
	@IBOutlet private weak var parentView: UIView!

    public override func awakeFromNib() {
        super.awakeFromNib()
		parentView.addBorder()
		parentView.dropCorner()
    }

	public func setData(name: String, type: String) {
		selectionStyle = .none
		payloadName.text = name
		payloadType.text = type
	}
	
}
