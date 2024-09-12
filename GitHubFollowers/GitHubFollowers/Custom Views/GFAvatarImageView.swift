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
    
    let placeholderImage = UIImage(named: "GFPlaceholder")
    
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
    
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = urlString
        
        if let image = cache.object(forKey: cacheKey as NSString) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey as NSString)
            
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
