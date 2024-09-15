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
        removeBlurEffect()
    }
    
    
    // MARK: - createDismissKeyboard
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: - keyboardHiding
    private func configureKeyboardHiding() {
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
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
    
    
    
    // MARK: - pushFollowersVC
    @objc func pushFollowersVC() {
        view.endEditing(true)
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThred(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😉", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListVC(username: usernameTextField.text ?? "")
        
        addBlurEffect()
        
        navigationController?.pushViewController(followerListVC, animated: true)

//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//        self.removeBlurEffect()
//        }
    }
    
   
    // MARK: - configureImageLogo
    func configureLogoImageView() {
        view.addSubview(logoImageView)
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
