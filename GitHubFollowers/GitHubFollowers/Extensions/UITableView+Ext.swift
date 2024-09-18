//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/16/24.
//

import UIKit

extension UITableView {
        
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
