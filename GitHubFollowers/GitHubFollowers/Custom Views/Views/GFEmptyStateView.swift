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
    let screenWidth = UIScreen.main.bounds.width
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLable.text = message
    }
    
    
    private func calculateImageSize(for screenWidth: CGFloat) -> (width: CGFloat, height: CGFloat) {
        let isSmallScreen = screenWidth <= 380
     
        let imageWidthMultiplier: CGFloat = isSmallScreen ? 1.0 : 1.2
        let imageWidth: CGFloat = screenWidth * imageWidthMultiplier
        let imageHeight: CGFloat = imageWidth
        
        return (width: imageWidth, height: imageHeight)
    }
    
    
    private func configure() {
        addSubviews(messageLable, logoImageView)
        configureMessageLabel()
        configureLogoImgeView()
    }
    
    
    private func configureMessageLabel() {
        messageLable.numberOfLines = 3
        messageLable.textColor = .secondaryLabel
        
        let isSmallScreen = screenWidth <= 380
        
        let messageLableCenterYConstant: CGFloat = isSmallScreen ? -150 : -200
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLableCenterYConstant),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200)
            ])
    }

    
    private func configureLogoImgeView() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.alpha = 0.3
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageSize = calculateImageSize(for: screenWidth)
        
        let isSmallScreen = screenWidth <= 380
        
        let logoTrailingConstant: CGFloat = isSmallScreen ? 120 : 160
        let logoBottomConstant: CGFloat = isSmallScreen ? 0 : -20
        
        NSLayoutConstraint.activate([
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: logoTrailingConstant),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
            logoImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            logoImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        ])
    }
}
