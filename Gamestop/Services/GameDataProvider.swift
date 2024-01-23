//
//  GameDataProvider.swift
//  Gamestop
//
//  Created by nexsoft nexsoft on 13/10/22.
//

import Foundation
import CoreData

class GameDataProvider {
    
    var manager: CoreDataManager
    
    private let entityName: String = "FavoriteGames"
    
    @Published var savedEntities: [FavoriteGames] = []
    @Published var gameById: [FavoriteGames] = []
    
    init(coreDataManager: CoreDataManager = .instance){
        self.manager = coreDataManager
        self.getGames()
    }
    
    func updateGamesTabel(game: FavoriteGameModel) {
        if savedEntities.first(where: {$0.id == game.id }) != nil {
            
        } else {
            add(game: game)
        }
    }
    
    
    func getGameById(filter: Int) {
        let request = NSFetchRequest<FavoriteGames>(entityName: entityName)
        request.predicate = NSPredicate(format: "idGame == %@", NSNumber(value: filter))
        
        do {
            gameById = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching GamesEntity. \(error)")
        }
    }
    
    
    func getGames() {
        let request = NSFetchRequest<FavoriteGames>(entityName: entityName)
        do {
            savedEntities = try manager.context.fetch(request)
        } catch _ {
            
        }
    }
    
    func delete(id: Int) {
        
        guard let gameToDelete = getItem(id: id) else { return }
        manager.context.delete(gameToDelete)
        
        self.applyChanges()
        
        
    }
    
    private func add(game: FavoriteGameModel){
        let entity = FavoriteGames(context: manager.context)
        entity.id = game.id
        entity.idGame = Int64(game.idGame)
        entity.name = game.name
        entity.rating = game.rating
        entity.genres = game.genres
        entity.releasedDate = game.releasedDate
        entity.image = game.image
        self.applyChanges()
        
    }
    
    private func save() {
        manager.save()
    }
    
    private func applyChanges() {
        self.save()
        self.getGames()
    }
    
    private func getItem(id: Int) -> FavoriteGames? {
        for game in self.savedEntities {
            if id == game.idGame {
                return game
            }
        }
        
        return nil
    }
}
