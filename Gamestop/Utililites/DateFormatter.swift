//
//  File.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation

class DateFormatterUtil {
    static func formatDate(date: String) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateToFormat = dateFormatter.date(from: date) ?? Date.now
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "d MMM y"
        return formatter3.string(from: dateToFormat)
    }
}
