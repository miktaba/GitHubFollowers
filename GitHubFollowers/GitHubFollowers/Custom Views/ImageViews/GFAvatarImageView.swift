//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/9/24.
//

import UIKit
import Foundation

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
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
    
    
    func downloadImage(fromURL url: String) {
        Task {
            image = await NetworkManager.shared.downladImage(from: url) ?? placeholderImage
        }
    }
}
