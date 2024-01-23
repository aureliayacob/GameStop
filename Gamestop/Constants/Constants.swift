//
//  Constants.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import Foundation

public var tabItems = [
    TabBarItem(iconName: "heart", title: "Favorite"),
    TabBarItem(iconName: "home", title: "Home"),
    TabBarItem(iconName: "profile", title: "About")
    ]

public var apiKey: String {
    get {
        guard let filePath = Bundle.main.path(forResource: "RAWG-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find API_KEY in 'RAWG-Info.plist'.")
        }
        return value
    }
}
