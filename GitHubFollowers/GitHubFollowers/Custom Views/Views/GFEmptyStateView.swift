//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/12/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLable = GFTitleLable(textAligment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(message: String) {
        super.init(frame: .zero)
        messageLable.text = message
        configure()
    }
    
    
    private func configure() {
        addSubview(messageLable)
        addSubview(logoImageView)
        
        messageLable.numberOfLines = 3
        messageLable.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "GHLogoEmptyState")
        logoImageView.alpha = 0.3
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
        ])
    }
}
