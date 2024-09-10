//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/9/24.
//

import UIKit

let placeholderImage = UIImage(named: "GFPlaceholder")

class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
    }
}
