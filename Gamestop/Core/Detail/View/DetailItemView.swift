//
//  DetailItemView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import SwiftUI

struct DetailItemView: View {
    var title: String
    var description: String
    var body: some View {
        VStack {
            HStack{
                Text(title)
                    .foregroundColor(Color.theme.primaryText.opacity(0.7))
                Spacer()
                Text(description)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(5)
                    .frame(maxWidth: 250, alignment: .trailing)
                
            }
            .foregroundColor(Color.theme.primaryText)
            .font(.caption)
            .padding(.vertical)
            Divider()
                .background(Color.theme.primaryText.opacity(0.5))
        }
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background
            
            VStack{
                DetailItemView(title: "Genre", description: "Action, Action")
                DetailItemView(title: "Genre", description: "PC, Xbox Series S/X, PlayStation 4, PlayStation 3, Xbox 360, Xbox One, PlayStation 5")
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
