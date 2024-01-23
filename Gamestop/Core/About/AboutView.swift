//
//  SwiftUIView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 04/10/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 15 ){
                Image("aurel")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
                Text("Developed by : ")
                    .fontWeight(.semibold)
                    .font(.headline)
                    .padding()
                
                AboutDetailView(title: "Name", desc: "Devida Aurelia Yacob")
                AboutDetailView(title: "Date of birth", desc: "December 29, 1999")
                AboutDetailView(title: "Email", desc: "aureliayacob@gmail.com")
                AboutDetailView(title: "Address", desc: "Tangerang")
                
                Spacer()
            }
            .font(.subheadline)
            .foregroundColor(.theme.primaryText)
            .padding()
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

