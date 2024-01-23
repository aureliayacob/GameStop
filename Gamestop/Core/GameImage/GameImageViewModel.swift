//
//  GameImageViewModel.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation
import UIKit
import Combine


class GameImageViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let dataService: GameImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(backgroundImage: String){
        
        self.dataService = GameImageService(backgroundImage: backgroundImage)
        self.isLoading = true
        addSubscribers()
    }
    
    private func addSubscribers(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (image) in
                self?.image = image
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
