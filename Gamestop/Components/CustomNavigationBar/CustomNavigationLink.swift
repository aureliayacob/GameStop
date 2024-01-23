//
//  CustomNavigationLink.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 03/10/22.
//

import SwiftUI

struct CustomNavigationLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label){
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavigationBarContainer {destination}
                .navigationBarHidden(true)
        } label: {
            label
        }
        
    }
}

struct CustomNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationLink(destination: Color.theme.midnight) {
            Text("Go")
        }
    }
}
