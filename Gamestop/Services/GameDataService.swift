//
//  GameDataService.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation
import Combine

class GameDataService {
    @Published var allGamesIsError: Bool = false
    @Published var popularGamesIsError: Bool = false
    @Published var searchGamesIsError: Bool = false
    
    @Published var allGames: [Result] = []
    @Published var popularGames: [Result] = []
    @Published var searchResult: [SearchResultItem] = []
    @Published var resultCount = 99
    
    var cancelables = Set<AnyCancellable>()
    var gameSubscription: AnyCancellable?
    var popularGameSubscription: AnyCancellable?
    var network = Network.shared
    
    
    init(){
        
        initData()
        
    }
    func initData(){
        getGames()
        getPopularGames()
    }
    
    func reload(){
        getGames()
        getPopularGames()
    }
    
    func reloadAllGames(){
        getGames()
    }
    func reloadPopularGames(){
        getPopularGames()
    }
    
    private func getGames(){
        guard let url = URL(string:"https://api.rawg.io/api/games?key=\(apiKey)&page_size=15&page=1") else {return}
        
        gameSubscription = NetworkingManager.download(url: url)
            .decode(type: AllGames.self, decoder: JSONDecoder())
        
            .sink(receiveCompletion: { [weak self]
                completion in
                switch completion {
                case .finished:
                    self?.allGamesIsError = false
                    break
                case .failure(let error):
                    print(error)
                    self?.allGamesIsError = true
                }
            },
                  receiveValue: {  [weak self] (returnedGames) in
                self?.allGamesIsError = false
                self?.allGames = returnedGames.results ?? []
                self?.gameSubscription?.cancel()
            })
        
    }
    
    private func getPopularGames(){
        guard let url = URL(string: "https://api.rawg.io/api/games?key=\(apiKey)&ordering=-metacritic&dates=2022-01-01&page_size=15") else {return}
        
        popularGameSubscription = NetworkingManager.download(url: url)
            .decode(type: AllGames.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self]
                completion in
                switch completion {
                case .finished:
                    self?.popularGamesIsError = false
                    break
                case .failure(let error):
                    print(error)
                    self?.popularGamesIsError = true
                }
            }, receiveValue: {  [weak self] (returnedGames) in
                self?.popularGames = returnedGames.results ?? []
                self?.allGamesIsError = false
                self?.popularGameSubscription?.cancel()
            })
        
        
    }
    
    
    func searchGame(for query: String){
        guard let url = URL(
            string: "https://api.rawg.io/api/games?search=\(query)&key=\(apiKey)") else {
            return
        }
        
        gameSubscription = NetworkingManager.download(url: url)
            .decode(type: SearchResultRoot.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self]
                completion in
                switch completion {
                case .finished:
                    self?.searchGamesIsError = false
                    break
                case .failure(let error):
                    print(error)
                    self?.searchGamesIsError = true
                }
            }, receiveValue: { [weak self] (returnedGames) in
                self?.searchResult = returnedGames.results
                self?.resultCount = returnedGames.count
                self?.allGamesIsError = false
                self?.gameSubscription?.cancel()
            })
        
    }
}
