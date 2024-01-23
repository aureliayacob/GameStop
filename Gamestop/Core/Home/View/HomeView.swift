//
//  HomeView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 23/09/22.
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    @EnvironmentObject var network: Network
    
    @State var showSkeleton = true
    @State var showSkeleton2 = true
    @State private var isConnected = false
    
    @State var isLast: Bool = false
    
    var body: some View {
        ZStack(alignment:.leading) {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        PopularLabel
                        ZStack{
                            if homeVM.popularGamesIsError {
                                ErrorPageView(title: "Fetching Error", title2: "Please check your internet connection and try again", withButton: true, tryAgainAction: {
                                    homeVM.reloadPopularGameData()
                                })
                            } else {
                                if showSkeleton {
                                    if network.connected {
                                        PopularSkeletonView
                                            .onAppear {
                                                homeVM.reloadPopularGameData()
                                            }
                                    } else {
                                        ErrorPageView(title: "Oops! No connection found!", title2: "Please check your internet connection and try again", withButton: true) {
                                            homeVM.reloadPopularGameData()
                                        }
                                    }
                                }
                                
                                if !homeVM.popularGames.isEmpty{
                                    PopularGameList
                                }
                            }
                            
                        }
                        .frame(maxHeight: 180)
                        .padding(.bottom)
                        
                        
                        BrowseLabel
                        ZStack(alignment: .center) {
                            if homeVM.allGamesIsError {
                                ErrorPageView(title: "Fetching Error", title2: "Please check your internet connection and try again", withButton: true, tryAgainAction: {
                                    homeVM.reloadAllGameData()
                                })
                            } else {
                                if showSkeleton2 {
                                    ZStack {
                                        
                                        if network.connected {
                                            BrowseSkeleton
                                                .onAppear {
                                                    homeVM.reloadAllGameData()
                                                }
                                        } else {
                                            ErrorPageView(title: "Oops! No connection found!", title2: "Please check your internet connection and try again", withButton: true) {
                                                homeVM.reloadData()
                                            }
                                        }
                                    }
                                }
                                if !homeVM.allGames.isEmpty {
                                    AllBrowseGame
                                }
                            }
                        }
                    } // vstack
                    .foregroundColor(Color.theme.primaryText)
                } // scrollview
            }
        }.onAppear {
            
        }
    }
}

extension HomeView {
    private var PopularLabel: some View {
        Text("Popular Releases 🏆")
            .font(.title3)
            .fontWeight(.bold)
            .padding(8)
    }
    
    private var BrowseLabel: some View {
        Text("Browse Games")
            .font(.title3)
            .fontWeight(.bold)
            .padding(8)
    }
    
    private var PopularSkeletonView: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                GameItemPlaceholder()
                GameItemPlaceholder()
            }
            .redacted(reason: showSkeleton ? .placeholder : [])
        }
    }
    
    private var PopularGameList: some View {
        ScrollView(.horizontal, showsIndicators:
                    false) {
            HStack(spacing: 15) {
                ForEach(homeVM.popularGames, id: \.id) {
                    game in
                    
                    CustomNavigationLink(destination: DetailView(game: game)) {
                        GameItemView(game: game)
                    }
                    
                }
            }
            .frame(height: 140)
            .onAppear(perform: {
                self.showSkeleton = false
            })
        }
    }
    
    private var BrowseSkeleton: some View {
        VStack{
            ForEach(0...4, id: \.self){ _ in
                GameVerticalItemPlaceholder()
            }
        } .padding(8)
            .redacted(reason: showSkeleton2 ? .placeholder : [])
    }
    
    private var AllBrowseGame: some View {
        VStack(spacing: 15) {
            
            ForEach(homeVM.allGames, id: \.id){
                game in
                CustomNavigationLink(destination: DetailView(game: game)) {
                    GameVerticalItemView(game: game)
                }
            }
        }
        .padding(8)
        .onAppear {
            self.showSkeleton2 = false
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
