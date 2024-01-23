//
//  GameViewUtils.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation

class GameViewUtils {
    
    
    static func loadGenres(genres: [Genre]) -> String {
        if !genres.isEmpty{
            if genres.count > 1 {
                let joined = genres.map { $0.name ?? "" }.joined(separator: ", ")
                return joined
            }
            return genres[0].name ?? ""
        }
        return "-"
        
    }
    
    static func loadPlatforms(platforms: [PlatformElement]) -> String {
        if !platforms.isEmpty{
            if platforms.count > 1 {
                let joined = platforms.map { $0.platform?.name ?? "" }.joined(separator: ", ")
                return joined
            }
            return platforms[0].platform?.name ?? ""
        }
        return "-"
        
    }

    static func loadDevelopers(developers: [Developer]) -> String {
        if !developers.isEmpty{
            if developers.count > 1 {
                let joined = developers.map { $0.name ?? "" }.joined(separator: ", ")
                return joined
            }
            return developers[0].name ?? ""
        }
        return "-"
        
    }
    
    static func loadPublishers(publishers: [Publisher]) -> String {
        if !publishers.isEmpty{
            if publishers.count > 1 {
                let joined = publishers.map { $0.name ?? "" }.joined(separator: ", ")
                return joined
            }
            return publishers[0].name ?? ""
        }
        return "-"
        
    }
    
   
}
