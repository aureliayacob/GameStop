//
//  GameVerticalItemPlaceholder.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 04/10/22.
//

import SwiftUI

struct GameVerticalItemPlaceholder: View {
    var body: some View {
        HStack {
            
            Color.gray.opacity(0.5)
                .frame(width: 90, height: 90)
                .cornerRadius(16)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text("Placeholder")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("Genres")
                    .font(.footnote)
                    .padding(.bottom)
                
                HStack(spacing: 0){
                    Text("5.0")
                    Image(systemName: "star.fill")
                    Spacer()
                    Text("04 Oct 2022")
                    
                }.font(.footnote)
            }
            
        }
    }
}

struct GameVerticalItemPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        GameVerticalItemPlaceholder()
    }
}
