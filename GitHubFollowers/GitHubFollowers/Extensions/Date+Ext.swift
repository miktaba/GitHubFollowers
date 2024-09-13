//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/13/24.
//

import Foundation

extension Date {
    
    func covertToMonthYearFormat() -> String {
        let datetFormatter = DateFormatter()
        datetFormatter.dateFormat = "MMM yyyy"
        return datetFormatter.string(from: self)
    }
}
