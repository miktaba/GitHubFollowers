//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/15/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {

    static private let defalts = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(
        favorite: Follower,
        actionType: PersistenceActionType,
        completed: @escaping (GFError?) -> Void
    ) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defalts.object(forKey: "favorites") as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unebleToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encoderFavorites = try encoder.encode(favorites)
            defalts.setValue(encoderFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unebleToFavorite
        }
    }
}
