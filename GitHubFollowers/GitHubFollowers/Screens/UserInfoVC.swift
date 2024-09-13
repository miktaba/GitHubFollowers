//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/13/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLable = GFBodyLable(textAligment: .center)
    
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        ConfigureViewController()
        layoutUI()
        getUserInfo()
    }
    
    
    func ConfigureViewController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUsername(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case.failure(let error):
                self.presentGFAlertOnMainThred(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        
        self.dateLable.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLable]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThred(
                title: "Invalid URL",
                message: "The URL attached to this user is invalid.",
                buttonTitle: "OK"
            )
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThred(title: "No followers", message: "This user has no followers.", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
    
}
