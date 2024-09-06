//
//  UIViiewController + Ext.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/6/24.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThred(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
