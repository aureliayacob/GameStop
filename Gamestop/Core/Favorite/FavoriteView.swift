//
//  FavoritePaeView.swift
//  Gamestop
//
//  Created by nexsoft nexsoft on 23/10/22.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject var vm: FavoriteViewModel =  FavoriteViewModel()
    @EnvironmentObject var network: Network
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack{
                
                if !vm.allFavoriteGames.isEmpty {
                        favoriteGamesListView
                    
                
            } else if vm.allFavoriteGames.isEmpty {
                Spacer()
                Text("No Favorite Games Found")
                    .foregroundColor(Color.theme.pink)
                    .font(.headline)
                
            }
            Spacer()
        }
        .onAppear {
            vm.getGames()
        }
        
    }
}
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}

extension FavoriteView {
    private var favoriteGamesListView: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.allFavoriteGames, id: \.id){
                    game  in
                    
                    CustomNavigationLink(destination: DetailView(favoriteGame: game)) {
                        
                        
                        FavoriteGameItemView(game:
                                                FavoriteGameModel(
                                                    idGame: Int(game.idGame),
                                                    name: game.name ?? "",
                                                    genres: game.genres ?? "",
                                                    rating: game.rating,
                                                    releasedDate: game.releasedDate ?? "",
                                                    image: game.image ?? ""))
                    }
                    
                    
                }
                .listRowBackground(Color.theme.background)
            }
            .padding()
        }
    }
}
