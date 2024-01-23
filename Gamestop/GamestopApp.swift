//
//  GamestopApp.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 23/09/22.
//

import SwiftUI

@main
struct GamestopApp: App {
    
    @StateObject var vm = HomeViewModel()
    @StateObject var network = Network()
     
        
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.pink)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.pink)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView()
                    .navigationBarHidden(true)
                    .preferredColorScheme(.dark)
            }
            .environmentObject(vm)
            .environmentObject(network)
           
        }
        
    }
}
