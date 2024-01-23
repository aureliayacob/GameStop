//
//  AppView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 04/10/22.
//

import SwiftUI

struct AppView: View {
    @State private var selection = tabItems[1]
    var body: some View {
        
        TabContainerView(selection: $selection) {
            
            
            FavoriteView()
                .tabBarItem(tab: tabItems[0], selection: $selection)
            
            HomeView()
                .tabBarItem(tab: tabItems[1], selection: $selection)
            
            AboutView()
                .tabBarItem(tab: tabItems[2], selection: $selection)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
