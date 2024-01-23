//
//  AboutDetailView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 11/10/22.
//

import SwiftUI

struct AboutDetailView: View {
    var title: String
    var desc: String
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Text(desc)
                .fontWeight(.semibold)
        }
        .font(.subheadline)
    }
}


