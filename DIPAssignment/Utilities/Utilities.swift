//
//  Utilities.swift
//  PayPayAssignment
//
//  Created by Tejas on 15/06/21.
//  Copyright © 2020 Tejas Patelia. All rights reserved.
//


import Foundation

public final class Utilities {
    
    class func convertTimestampToDate(ts :Double) -> String {
        return convertDate(to: Date(timeIntervalSince1970: ts))
    }

	private class func convertDate(to date:Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let myString = formatter.string(from: date)
		let yourDate = formatter.date(from: myString)
		formatter.dateFormat = "dd-MMM-yyyy"
		let myStringDate = formatter.string(from: yourDate ?? Date())
		return myStringDate
	}

    class func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat  = "EEEE"
        let myString = formatter.string(from: date as Date)
        return myString
    }

    class func dayForDate(date: Date) -> String {
        let result = Calendar.current.component(Calendar.Component.day, from: date)
        return "\(result)"
    }
    
    static func convertFromISODate(strDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") 
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from:strDate)
        return date
    }
    
    class func calculateDateDifference(toDate: Date, fromDate: Date) -> String {
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day,.hour,.minute,.second]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
        let str = dateComponentsFormatter.string(from: fromDate, to: toDate)
        return str ?? ""
    }

	public static func convertDate(date: String, from: String = "MM/dd/yyyy", to value: String = "yyyy-MM-dd") -> String? {
		let dateFormat = DateFormatter()
		dateFormat.dateFormat = from
		let showDate = dateFormat.date(from: date)
		dateFormat.dateFormat = value
		let resultString = dateFormat.string(from: showDate ?? Date())
		return resultString
	}

}
