//
//  GameVerticalItemView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import SwiftUI

struct GameVerticalItemView: View {
    @StateObject private var imgVM: GameImageViewModel
    private var game: Result

    init(game: Result){
        _imgVM = StateObject(wrappedValue: GameImageViewModel(backgroundImage: game.backgroundImage ?? ""))
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
                        .cornerRadius(16)
                        .padding(.trailing, 8)
                    
                } else if imgVM.isLoading {
                    Color.gray.opacity(0.5)
                        .frame(width: 90, height: 90)
                        .cornerRadius(16)
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
                    Text("\(game.name ?? "")")
                        .font(.headline)
                    .fontWeight(.bold)
                    Text("\(GameViewUtils.loadGenres(genres: game.genres ?? []))")
                        .font(.footnote)
                        .padding(.bottom)
                    
                    HStack(spacing: 0){
                        Text("\(String(format: "%.2f", game.rating ?? 0.0))")
                        Image(systemName: "star.fill")
                        Spacer()
                        Text(DateFormatterUtil.formatDate(date:game.released ?? ""))
                            
                    }.font(.footnote)
                }
               
            }
        }
    }
}
