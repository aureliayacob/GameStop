//
//  Network.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 04/10/22.
//

import Foundation
import Network
import Combine

class Network: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    static let shared = Network()
    
    @Published private(set) var connected: Bool = false
    var cancelables = Set<AnyCancellable>()
    var monitorCubscription: AnyCancellable?
    
    init(){
        checkConnection()
    }
    
    func checkConnection(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.connected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.connected = false
                }
            }
        }
        monitor.start(queue: queue)
        
    }
}


