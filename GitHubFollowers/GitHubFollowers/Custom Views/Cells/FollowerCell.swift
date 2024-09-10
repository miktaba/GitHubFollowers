//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/9/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLable(textAligment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAvatar()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    
    private func configureAvatar() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate(
            [
                avatarImageView.topAnchor.constraint(
                    equalTo: topAnchor,
                    constant: padding
                ),
                avatarImageView.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: padding
                ),
                avatarImageView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -padding
                ),
                avatarImageView.heightAnchor.constraint(
                    equalTo: avatarImageView.widthAnchor
                ),
                
                
                usernameLabel.topAnchor.constraint(
                    equalTo: avatarImageView.bottomAnchor,
                    constant: 12
                ),
                usernameLabel.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: padding
                ),
                usernameLabel.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -padding
                ),
                usernameLabel.heightAnchor.constraint(equalToConstant: 20)
                
            ]
        )
    }
}
