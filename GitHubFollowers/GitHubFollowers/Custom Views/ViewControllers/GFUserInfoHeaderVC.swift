//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/13/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLable = GFTitleLable(textAligment: .left, fontSize: 34)
    let nameLable = GFSecondaryTitleLable(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLable = GFSecondaryTitleLable(fontSize: 18)
    let bioLabel = GFBodyLable(textAligment: .left)
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }

    
    func configureUIElements() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLable.text = user.login
        nameLable.text = user.name ?? ""
        locationLable.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? ""
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLable)
        view.addSubview(nameLable)
        view.addSubview(locationImageView)
        view.addSubview(locationLable)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLable.heightAnchor.constraint(equalToConstant: 38),
            
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
