//
//  StoreButtonVIew.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import SwiftUI

struct StoreButtonVIew: View {
    var storeName: String
    @State var iconName: String = ""
    var body: some View {
        VStack{
            Image(iconName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.theme.primaryText)
                .scaledToFit()
                .frame(width: 45, height: 45)
            
            Text(storeName)
                .font(.caption)
                .foregroundColor(Color.theme.primaryText)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            
        }
        .frame(width: 90, height: 100)
        .background(Color.theme.gray)
        .cornerRadius(8)
        .onAppear{
            if storeName == "Steam" {
                self.iconName = "steam"
            } else if storeName == "Xbox Store" || storeName == "Xbox 360 Store"{
                self.iconName = "xbox"
            } else if storeName == "PlayStation Store" {
                self.iconName = "playstation"
            } else if storeName == "App Store" {
                self.iconName = "app-store"
            } else if storeName == "GOG" {
                self.iconName = "gog"
            } else if storeName == "Nintendo Store" {
                self.iconName = "nintendo-switch"
            } else if storeName == "Google Play" {
                self.iconName = "playstore"
            } else if storeName == "itch.io" {
                self.iconName = "itch-io"
            } else if storeName == "Epic Games" {
                self.iconName = "epic-games"
            }
            
        }
    }
}

struct StoreButtonVIew_Previews: PreviewProvider {
    static var previews: some View {
        StoreButtonVIew(storeName: "Steam")
    }
}
