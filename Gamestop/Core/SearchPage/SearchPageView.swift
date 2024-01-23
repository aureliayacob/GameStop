//
//  SearchPageView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 05/10/22.
//

import SwiftUI

struct SearchPageView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @EnvironmentObject var network: Network
    
    private var  searchResult: [Result] = []
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack{
                
                CustomSearchBarView(searchText: $vm.searchText) {
                    vm.searchResult = []
                    vm.searchItems(searchText: vm.searchText)
                    
                } onClearTap: {
                    UIApplication.shared.endEditing()
                    vm.searchText = ""
                }
                
                if vm.isLoading {
                    if network.connected {
                        Spacer()
                        ProgressView("Searching...")
                            .font(.headline)
                            .foregroundColor(Color.theme.pink)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.theme.pink))
                            .onAppear {
                                if !vm.searchText.isEmpty {
                                    vm.searchItems(searchText: vm.searchText)
                                }
                            }
                         
                    } else {
                        ErrorPageView(title: "Oops! No connection found!", title2: "Please check your internet connection and try again", withButton: true) {
                            vm.searchItems(searchText: vm.searchText)
                        }
                    }
                }
                
                if !vm.searchResult.isEmpty {
                    List {
                        ForEach(vm.searchResult, id: \.id){
                            game  in
                            GameVerticalItemView(game:
                                                    Result(
                                                        id: game.id ?? 0,
                                                        slig: game.slug ?? "",
                                                        name: game.name ?? "-",
                                                        released: game.released ?? "",
                                                        genre: game.genres ?? [],
                                                        rating: game.rating ?? 0.0,
                                                        ratingTop: game.ratingTop ?? 0,
                                                        ratings: game.ratings ?? [],
                                                        ratingsCount: game.ratingsCount ?? 0,
                                                        backgroundImage: game.backgroundImage ?? ""))
                        }
                        .listRowBackground(Color.theme.background)
                    }
                    
                    .listStyle(.plain)
                } else if vm.searchResult.isEmpty && vm.searchResultCount == 0 && !vm.searchText.isEmpty{
                    Spacer()
                    Text("No Result Found")
                        .foregroundColor(Color.theme.pink)
                        .font(.headline)
                    
                }
                Spacer()
            }
        }
        .onDisappear {
            vm.searchText = ""
            vm.searchResult = []
        }
    }
}


