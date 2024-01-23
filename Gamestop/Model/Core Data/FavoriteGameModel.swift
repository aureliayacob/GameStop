//
//  FavoriteGame.swift
//  Gamestop
//
//  Created by nexsoft nexsoft on 23/10/22.
//

import Foundation

struct FavoriteGameModel {
    var id: String
    var idGame: Int
    var name: String
    var genres: String
    var rating: Double
    var releasedDate: String
    var image: String
    
    init(idGame: Int,
         name: String,
         genres: String,
         rating: Double,
         releasedDate: String,
         image: String){
        self.id = UUID().uuidString
        self.idGame = idGame
        self.name = name
        self.genres = genres
        self.rating = rating
        self.releasedDate = releasedDate
        self.image = image
    }
}
