//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 8/31/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(color: .systemGreen, title: "Get Followers",systemImageName: "person.3")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)
        configureLogoImageView()
        configureTextField()
        confirureCallToActionButton()
        createDismissKeyboardTapGesture()
        configureKeyboardHiding()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        removeBlurEffect()
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureKeyboardHiding() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    
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
            
            let keyboardHeight = CGFloat(keyboardFrame.cgRectValue.height)
            UIView.animate(withDuration: 0.3) {
                self.callToActionButton.transform = CGAffineTransform(translationX: 0, y: keyboardHeight - 50)
            }
        }
    }
    
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
        
        UIView.animate(withDuration: 0.3) {
            self.callToActionButton.transform = .identity
        }
    }
    
    
    @objc func pushFollowersVC() {
        view.endEditing(true)
        
        guard isUsernameEntered else {
            presentGFAlert(
                title: "Empty Username",
                message: "Please enter a username. We need to know who to look for 😉",
                buttonTitle: "Ok"
            )
            return
        }
        
        let followerListVC = FollowerListVC(username: usernameTextField.text ?? "")
        
        addBlurEffect()
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        NSLayoutConstraint.activate(
            [
                logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.heightAnchor.constraint(equalToConstant: 300),
                logoImageView.widthAnchor.constraint(equalToConstant: 300)
            ]
        )
    }
    
    
    func configureTextField() {
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
    
    
    func confirureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
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
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        return true
    }
}


extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    @objc private func trap() {
        Static.responder = self
    }
}
