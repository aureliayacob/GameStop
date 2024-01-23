//
//  FavoriteGameItemView.swift
//  Gamestop
//
//  Created by nexsoft nexsoft on 25/10/22.
//

import SwiftUI

struct FavoriteGameItemView: View {
  
    @StateObject private var imgVM: GameImageViewModel
    private var game: FavoriteGameModel

    init(game: FavoriteGameModel){
        _imgVM = StateObject(wrappedValue: GameImageViewModel(backgroundImage: game.image))
        self.game = game
    }

    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            HStack{
                if let image = imgVM.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .clipped()
                        .cornerRadius(6)
                        .padding(.trailing, 8)
                    
                } else if imgVM.isLoading {
                    Color.gray.opacity(0.5)
                        .frame(width: 90, height: 90)
                        .cornerRadius(6)
                        .padding(.trailing, 8)
                        .redacted(reason: .placeholder)
                } else {
                    ZStack {
                        Image("noimage")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.theme.primaryText.opacity(0.5))
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 8)
                        .opacity(0.5)
                    }.frame(width: 90, height: 90)
                }
                
                VStack(alignment: .leading) {
                    Text("\(game.name )")
                        .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    Text(game.genres)
                        .font(.footnote)
                        .padding(.bottom)
                    
                    HStack(spacing: 0){
                        Text("\(String(format: "%.2f", game.rating ))")
                        Image(systemName: "star.fill")
                        Spacer()
                        Text(DateFormatterUtil.formatDate(date:game.releasedDate ))
                            
                    }.font(.footnote)
                }
                .foregroundColor(Color.theme.primaryText)
               
            }
        }
    }
}



