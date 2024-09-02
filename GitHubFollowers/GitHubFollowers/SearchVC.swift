//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 8/31/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let userrnameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        confirureCallToActionButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 300),
            logoImageView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(userrnameTextField)
        
        NSLayoutConstraint.activate([
            userrnameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            userrnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userrnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userrnameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func confirureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
