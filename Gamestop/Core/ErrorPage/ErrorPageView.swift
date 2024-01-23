//
//  ErrorPageView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 10/10/22.
//

import SwiftUI

struct ErrorPageView: View {
    
    var title: String
    var title2: String
    var withButton: Bool
    var tryAgainAction: () -> () = {}
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack{
            Color.theme.background.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(title2)
                    .font(.footnote)
                
                if withButton {
                    Button {
                        tryAgainAction()
                    } label: {
                        HStack {
                            Text("Try Again")
                                .fontWeight(.bold)
                            Image(systemName: "arrow.counterclockwise")
                        }
                        .foregroundColor(.theme.pink)
                        .font(.subheadline)
                        .padding()
                    }
                }
                
            }.foregroundColor(Color.theme.primaryText.opacity(0.5))
                .padding()
        }
        
    }
}

struct ErrorPageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorPageView(title: "Fethcing Error", title2: "Please check your internet connection and try again", withButton: true, tryAgainAction: {})
    }
}
