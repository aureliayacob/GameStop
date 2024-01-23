//
//  GameItemPlaceholder.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 04/10/22.
//

import SwiftUI

struct GameItemPlaceholder: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                    .frame(width: 210, height: 140)
            LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
            VStack(alignment: .leading){
                Spacer()
                Text("The Legend of Zelda: Ocarina of Time")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("Genres")
                    .font(.footnote)
                    .padding(.bottom, 0.5)
                HStack{
                    HStack(spacing: 1){
                        Text("5.0")
                            .font(.footnote)
                        Image(systemName: "star.fill")
                            .font(.footnote)
                    }
                    Spacer()
                    Text("4 Oct 2022")
                        .font(.footnote)
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            .foregroundColor(.white)
            
        }
        .frame(width: 210, height: 140)
        .cornerRadius(12)
    }
}

struct GameItemPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        GameItemPlaceholder()
    }
}
