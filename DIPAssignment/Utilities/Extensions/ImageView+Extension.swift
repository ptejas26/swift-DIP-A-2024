//
//  ImageView+Extension.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//

import UIKit
import Foundation

typealias ImageResponse = (UIImage?,Error?)->()
let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    
	func downloadImage(imageURL: String, completionHandler: @escaping ImageResponse) {

		guard let url = URL(string: imageURL) else { return }
		let urlRequest = URLRequest(url: url)

		if let cachedImg = cache.object(forKey: NSString(string: imageURL)) {
			completionHandler(cachedImg,nil)
		} else {
			let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlresponse, error) in
				if error == nil {

					guard let imgData = data else{return}

					if let image = UIImage(data: imgData) {

						cache.setObject(image, forKey: NSString(string: imageURL))
						completionHandler(image,nil)
					}
				}else{
					completionHandler(nil,error)
				}
			}
			urlSession.resume()
		}
	}
}

