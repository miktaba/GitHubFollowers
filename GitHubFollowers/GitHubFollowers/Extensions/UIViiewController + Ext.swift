//
//  UIViiewController + Ext.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/6/24.
//

import UIKit
import SafariServices


extension UIViewController {
    
    func presentGFAlertOnMainThred(
        title: String,
        message: String,
        buttonTitle: String
    ) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(
                title: title,
                message: message,
                buttonTitle: buttonTitle
            )
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    func addBlurEffect() {
        guard self.view.viewWithTag(1001) == nil else { return }
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 1001
        
        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.tag = 1002
        
        self.view.addSubview(dimmingView)
        self.view.addSubview(blurEffectView)
    }
    
    func removeBlurEffect() {
        if let blurEffectView = self.view.viewWithTag(1001) {
            blurEffectView.removeFromSuperview()
        }
        if let dimmingView = self.view.viewWithTag(1002) {
            dimmingView.removeFromSuperview()
        }
    }
}

