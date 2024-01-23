//
//  CustomSearchBarView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 05/10/22.
//

import SwiftUI

struct CustomSearchBarView: View {
    @Binding var searchText: String
    var onSubmit: () -> Void
    var onTapClear: () -> Void
    
    init(searchText: Binding<String>, onSubmit: @escaping () -> Void, onClearTap: @escaping () -> Void){
        self._searchText = searchText
        self.onSubmit = onSubmit
        self.onTapClear = onClearTap
    }
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(Color.theme.pink)
                .padding(.trailing)
                .opacity(0.0)
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(searchText.isEmpty ? .theme.background : .theme.pink)
                
                TextField("", text: $searchText)
                    .placeholder(when: searchText.isEmpty, placeholder: {
                        Text("Search...").foregroundColor(.gray)
                    })
                    .foregroundColor(.theme.pink)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .foregroundColor(.theme.pink)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                onTapClear()
                            }
                        , alignment: .trailing)
                
                    .onSubmit {
                        onSubmit()
                    }
            }
            .font(.subheadline)                .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.theme.primaryText)
                    .shadow(color: .theme.background.opacity(0.15), radius: 10, x: 0, y: 0)
            )
            .padding()
        }
    }
}

struct CustomSearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBarView(searchText: .constant(""), onSubmit: {}, onClearTap: {})
            .previewLayout(.sizeThatFits)
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}
