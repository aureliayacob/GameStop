//
//  CustomNavigationBar.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 03/10/22.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    @Environment(\.presentationMode) var presentationMode
    @GestureState private var dragOffset = CGSize.zero
    var body: some View {
        
            ZStack {
               
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 5)
                            .foregroundColor(Color.white)
                            .padding()
                            .shadow(color: .theme.background, radius: 5, x: 0, y: 0)
                    }

                    Spacer()
                }
                
            }
            .frame(height: 65)
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                 if(value.startLocation.x < 20 &&
                            value.translation.width > 100) {
                     self.presentationMode.wrappedValue.dismiss()
                 }
            }))
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            VStack {
                CustomNavigationBar()
                Spacer()
            }
        }
    }
}
