//
//  DetailViewModel.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 02/10/22.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var detailGame: DetailGame?
    @Published var getDetailIsError: Bool = false
    @Published var isFavorite: Bool = false
    
    @Published var gameById: [FavoriteGames] = []
    
    private var detailDataService: GameDetailDataService
    private var gameDatProvider = GameDataProvider()
    
    var cancellables = Set<AnyCancellable>()
    
    init(id: String){
        
        self.detailDataService = GameDetailDataService(id: id)
        addSubscriptions()
        
        gameDatProvider.getGameById(filter: Int(id) ?? 0)
        isGameAddedToFavorite()
    }
    
    func addSubscriptions() {
        detailDataService.$detailGame
            .sink { [weak self] (detailGame) in
                self?.detailGame = detailGame
            }
            .store(in: &cancellables)
        
        
        detailDataService.$getDetailIsError
            .sink { [weak self] isError in
                self?.getDetailIsError = isError
            }
            .store(in: &cancellables)
        
        
        
        gameDatProvider.$gameById
            .sink { [weak self] favoriteGames in
                self?.gameById = favoriteGames
            }
            .store(in: &cancellables)
    }
    
    func reloadDetail(id: String){
        detailDataService.reloadDetailGame(id: id)
    }
    
    func isGameAddedToFavorite() {
        if self.gameById.isEmpty {
            self.isFavorite = false
        } else {
            self.isFavorite = true
        }
    }
    
    func doAddToFavorites(game: FavoriteGameModel) -> FavoriteGameModel {
        
        if self.gameById.isEmpty && isFavorite == false {
            gameDatProvider.updateGamesTabel(game: game)
            self.isFavorite = true
            gameDatProvider.getGameById(filter: Int(game.idGame) )
           
            
        } else  if !self.gameById.isEmpty && isFavorite == true {
            gameDatProvider.delete(id: Int(game.idGame) )
            self.isFavorite = false
            gameDatProvider.getGameById(filter: Int(game.idGame) )
        }
        return game
    }
}
