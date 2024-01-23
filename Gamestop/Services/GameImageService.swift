//
//  GameImageService.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation
import Combine
import UIKit

class GameImageService {
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let backgroundImage: String
    
    init(backgroundImage: String){
        self.backgroundImage = backgroundImage
        getGameImage()
    }
    
    func getGameImage(){
        downloadGameImage()
    }
    
    func downloadGameImage(){
        guard let url = URL(string: backgroundImage) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
        
    }
}
