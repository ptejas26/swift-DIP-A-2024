//
//  Operation.swift
//  OperationsDemo
//
//  Created by Tejas Patelia on 13/01/21.
//

import Foundation


protocol OperationProtocol : AnyObject {
    func operationCanceled(string:String?)
	func operationCompleted(launchID: String, response: Any, message:String?)
    func operationError(error: Error?)
}

public final class Operations : Operation {
    var url: String!
    weak var delegate: OperationProtocol?
	var launchID: String = ""
    
	init(launchID: String, url: String, delegate: OperationProtocol) {
        super.init()
        self.url = url
		self.launchID = launchID
		self.delegate = delegate
        self.queuePriority = .high
    }
    
	public override func main() {
        if self.isCancelled {
            print("Operation has been cancelled")
            delegate?.operationCanceled(string: "Operation has been cancelled")
			return
        }

		if !self.isCancelled {

			ServiceManager.sharedInstance.getMethod(url: url) { (result) in

				if self.isCancelled {
					print("Operation has been cancelled")
					self.delegate?.operationCanceled(string: "Operation has been cancelled")
				}
				switch result {
				case .failure(let error):
					DispatchQueue.main.async {
						self.delegate?.operationError(error: error)
					}
				case .success(let response):
					print(response)
					DispatchQueue.main.async {
						self.delegate?.operationCompleted(launchID: self.launchID, response: response, message: "Operation Completed succesffully")
					}
				}
			}

			if self.isCancelled {
				print("Operation has been cancelled")
				delegate?.operationCanceled(string: "Operation has been cancelled")
				return
			}
		}

        if self.isCancelled {
            print("Operation has been cancelled")
            delegate?.operationCanceled(string: "Operation has been cancelled")
        }
    }
}
