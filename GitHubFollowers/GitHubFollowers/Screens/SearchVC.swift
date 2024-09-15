//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 8/31/24.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        confirureCallToActionButton()
        createDismissKeyboardTapGesture()
        
        configureKeyboardHiding()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - dismissKeyboard
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - keyboardHiding
    private func configureKeyboardHiding() {
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    // MARK: - pushFollowersVC
    @objc func pushFollowersVC() {
        view.endEditing(true)
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThred(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😉", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListVC()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    // MARK: - configureImageLogo
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate(
            [
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.heightAnchor.constraint(equalToConstant: 300),
                logoImageView.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
    }
    
    
    // MARK: - configureTextField
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate(
            [
                usernameTextField.topAnchor.constraint(
                    equalTo: logoImageView.bottomAnchor,
                    constant: 30
                ),
                usernameTextField.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 50
                ),
                usernameTextField.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -50
                ),
                usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
    
    // MARK: - confirureCallToActionButton
    func confirureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate(
            [
                callToActionButton.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -50
                ),
                callToActionButton.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 50
                ),
                callToActionButton.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -50
                ),
                callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
    }
    
}


// MARK: - Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        return true
    }
}


extension UIViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardFrameInView = view.convert(keyboardFrame.cgRectValue, from: view.window)
        let keyboardTopY = keyboardFrameInView.origin.y

        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY > keyboardTopY {
               let offset = textFieldBottomY - keyboardTopY + 20
               view.frame.origin.y = -offset
            
            if let searchVC = self as? SearchVC {
                searchVC.callToActionButton.isHidden = true
            }
        }
    }
}

extension UIViewController {
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
        
        if let searchVC = self as? SearchVC {
            searchVC.callToActionButton.isHidden = false
        }
    }
}

extension UIResponder {

    private struct Static {
        static weak var responder: UIResponder?
    }

    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }

    @objc private func _trap() {
        Static.responder = self
    }
}


