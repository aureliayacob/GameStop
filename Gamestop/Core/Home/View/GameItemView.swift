//
//  GameItemView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 23/09/22.
//

import SwiftUI
import StarRateView

struct GameItemView: View {
    
    @StateObject var imgVM: GameImageViewModel
    private var game: Result
    private var imgWidth: CGFloat = 210
    private var imgHeight: CGFloat = 140
    
    init(game: Result){
        _imgVM = StateObject(wrappedValue: GameImageViewModel(backgroundImage: game.backgroundImage ?? ""))
        self.game = game
    }
    
    var body: some View {
        ZStack {
            if let image = imgVM.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imgWidth, height: imgHeight)
                    .clipped()

            }
            else if imgVM.isLoading {
                Color.gray.opacity(0.5)
                .frame(width: imgWidth, height: imgHeight)
                .cornerRadius(16)
                .redacted(reason: .placeholder)
            }
            else if imgVM.image == nil{
                ZStack {
                    Color.gray.opacity(0.3)
                    Image("noimage")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .opacity(0.5)
                }
                .frame(width: imgWidth, height: imgHeight)
                
            }
          
            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading){
                Spacer()
                Text(game.name ?? "")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                Text("\(GameViewUtils.loadGenres(genres: game.genres ?? []))")
                    .font(.footnote)
                    .padding(.bottom, 0.5)
                
                HStack{
                    HStack(spacing: 1){
                        Text("\(String(format: "%.2f", game.rating ?? 0.0))")
                            .font(.footnote)
                        Image(systemName: "star.fill")
                            .font(.footnote)
                        
                    }
                    
                    Spacer()
                    
                    Text(DateFormatterUtil.formatDate(date:game.released ?? ""))
                        .font(.footnote)
                    
                }
                
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            .foregroundColor(.white)
            
        }
        .frame(width: 210, height: 140)
        .cornerRadius(16)
    }
}
