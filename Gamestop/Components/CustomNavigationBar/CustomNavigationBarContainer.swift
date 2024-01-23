//
//  CustomNavigationBarContainer.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 03/10/22.
//

import SwiftUI

struct CustomNavigationBarContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    
    var body: some View {
        
        ZStack{
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                CustomNavigationBar()
                Spacer()
            }
        }
    }
}

struct CustomNavigationBarContainer_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBarContainer {
            Color.theme.midnight
                .ignoresSafeArea()
        }
    }
}
