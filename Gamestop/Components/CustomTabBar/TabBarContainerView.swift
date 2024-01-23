//
//  TabBarContainerView.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 03/10/22.
//


import SwiftUI

public struct TabContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    @State var showMagnifyingGlass: Bool = true
    @State var showEditButton: Bool = false
    @State var title: String = "G A M E S T O P"
    
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            ZStack {
                VStack(spacing:0) {
                    CustomHeaderView(showMagnifyingGlass: showMagnifyingGlass, title: title)
                    
                    ZStack {
                        content
                    }
                }
                VStack(spacing:0) {
                    Spacer()
                    TabBarView(tabItems: tabs, selection: $selection)
                }
            }
            
            .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
                self.tabs = value
            }
            
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut) {
                    if selection == tabItems[0] {
                        self.showMagnifyingGlass = true
                        self.showEditButton = false
                        self.title = "G A M E S T O P"
                    } else if selection == tabItems[2] {
                        self.showMagnifyingGlass = false
                        self.showEditButton = false
                        self.title = "FAVORITES"
                    } else {
                        self.showMagnifyingGlass = false
                        self.showEditButton = true
                        self.title = "ABOUT"
                    }
                }
            }
        }
        
    }
}
