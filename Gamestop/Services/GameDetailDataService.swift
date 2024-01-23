//
//  GameDetailDataService.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 02/10/22.
//

import Foundation
import Combine


class GameDetailDataService {
    
    var network = Network.shared
    
    @Published var detailGame: DetailGame? = nil
    @Published var getDetailIsError: Bool = false
    
    var cancelables = Set<AnyCancellable>()
    var detailSubscription: AnyCancellable?
    
    init(id: String){
        getDetailGame(id: id)
    }
    
    func reloadDetailGame(id: String){
        getDetailGame(id: id)
    }
    
    func getDetailGame(id: String){
        if network.connected {
            guard let url = URL(string: "https://api.rawg.io/api/games/\(id)?key=4654d910c39b449583a4608a74022372") else {
                return
            }
            
            detailSubscription = NetworkingManager.download(url: url)
                .decode(type: DetailGame.self, decoder: JSONDecoder())
                .sink(receiveCompletion: { [weak self]
                    completion in
                    switch completion {
                    case .finished:
                        self?.getDetailIsError = false
                        break
                    case .failure(let error):
                        print(error)
                        self?.getDetailIsError = true
                    }
                }, receiveValue: { [weak self] (detailGame) in
                    self?.detailGame = detailGame
                    self?.getDetailIsError = false
                    self?.detailSubscription?.cancel()
                })
        } else {
            self.getDetailIsError = true
        }
    }
}
