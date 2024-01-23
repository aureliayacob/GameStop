//
//  CustomNavigationBarView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 26/09/22.
//

import SwiftUI

struct CustomHeaderView: View {
    
    @State var searchText = ""
    var showMagnifyingGlass: Bool = false
    var showEditButton: Bool = false
    var title: String
    
    init(showMagnifyingGlass: Bool, title: String){
        self.showMagnifyingGlass = showMagnifyingGlass
        self.title = title
    }
    
    var body: some View {
    
        ZStack {
            Color.theme.background
            VStack {
                HStack{
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(Color.theme.pink)
                        .padding(.trailing)
                        .opacity(0.0)
                    Spacer()
                    Text(title)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.theme.pink)
                    Spacer()
                    withAnimation(.easeInOut(duration: 1.0)){
                        ZStack {
                            CustomNavigationLink(destination: SearchPageView()) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(Color.theme.gray)
                                    .padding(.trailing)
                            }
                            .opacity(showMagnifyingGlass ? 1.0 : 0.0)
                            
                            
                        }
                    }
                }
            }
            
        }
        .frame(height: 45)
        
    }
}

struct CustomNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomHeaderView(showMagnifyingGlass: false, title: "G A M E S T O P")
            .previewLayout(.sizeThatFits)
    }
}
