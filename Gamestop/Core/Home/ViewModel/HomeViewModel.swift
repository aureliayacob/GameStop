//
//  HomeViewModel.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allGamesIsError: Bool = false
    @Published var popularGamesIsError: Bool = false
    @Published var searchGamesIsError: Bool = false
    
    @Published var allGames: [Result] = []
    @Published var popularGames: [Result] = []
    @Published var isLoading: Bool = true
    @Published var searchText = ""
    @Published var searchResult: [SearchResultItem] = []
    @Published var searchResultCount = 99
    
    var cancellables = Set<AnyCancellable>()
    private let dataService = GameDataService()
    
    
    init(){
        addSubscriptions()
    }
    
    private func addSubscriptions(){
        dataService.$allGames
            .sink { [weak self] (returnedGames) in
                self?.allGames = returnedGames
                self?.isLoading = false
                
            }
            .store(in: &cancellables)
        
        dataService.$popularGames
            .sink { [weak self] (returnedGames) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.popularGames = returnedGames
                }
            }
            .store(in: &cancellables)
        
        dataService.$searchResult
            .combineLatest(dataService.$resultCount)
            .sink { [weak self] (resultItem, resultCount) in
                self?.searchResult = resultItem
                self?.searchResultCount = resultCount
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        dataService.$allGamesIsError
            .sink { [weak self] isError in
                self?.allGamesIsError = isError
            }
            .store(in: &cancellables)
        
        dataService.$popularGamesIsError
            .sink { [weak self] isError in
                self?.allGamesIsError = isError
                
            }
            .store(in: &cancellables)
        
        dataService.$searchGamesIsError
            .sink { [weak self] isError in
                self?.allGamesIsError = isError
            }
            .store(in: &cancellables)
        
    }
    func initData(){
        dataService.initData()
    }
    
    func reloadData() {
        dataService.reload()
    }
    
    func reloadAllGameData() {
        dataService.reloadAllGames()
    }
    
    func reloadPopularGameData() {
        dataService.reloadPopularGames()
    }
    
    func searchItems(searchText: String){
        dataService.searchGame(for: searchText)
        self.isLoading = true
    }
}


