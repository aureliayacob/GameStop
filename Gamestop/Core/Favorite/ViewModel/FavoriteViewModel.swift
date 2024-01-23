//
//  FavoriteViewModel.swift
//  Gamestop
//
//  Created by nexsoft nexsoft on 24/10/22.
//

import Foundation
import Combine
import CoreData


class FavoriteViewModel: ObservableObject {
    
    @Published var savedEntities: [FavoriteGames] = []
    @Published var allFavoriteGames: [FavoriteGames] = []
   
    private var gameDataProvider = GameDataProvider()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscriptions()
    }
    
    
    func addSubscriptions(){
        gameDataProvider.$savedEntities
            .sink { [weak self] favoriteGames in
                self?.allFavoriteGames = favoriteGames
            }
            .store(in: &cancellables)
            
    }
    
    func getGames(){
        gameDataProvider.getGames()}
    
    
}
