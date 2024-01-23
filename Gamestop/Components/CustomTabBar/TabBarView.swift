//
//  TabBarView.swift
//  iOSComponents
//
//  Created by Aurelia Yacob on 06/07/22.
//

import SwiftUI

public struct TabBarView: View {
    var tabItems: [TabBarItem]
    @Binding var selection: TabBarItem
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    public var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(tabItems, id: \.self){
                tab in
                tabView(tab: tab)
                    
            }
        }
        .background(Color.theme.midnight
            .shadow(color: .black, radius: 10, x: 0, y: 8)
            .clipShape(CurveShape(xAxis: xAxis))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .ignoresSafeArea(edges: .bottom))
        
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var tabItems = [TabBarItem(iconName: "home", title: "Home"), TabBarItem(iconName: "heart", title: "Store"), TabBarItem(iconName: "profile", title: "Profile")]
    static var previews: some View {
        ZStack {
            VStack {
                Spacer()
                TabBarView(tabItems: tabItems, selection: .constant(tabItems.first!))
            }
            
        }
    }
}

extension TabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        GeometryReader { reader in
            Button {
                withAnimation(.spring()){
                    selection = tab
                    xAxis = reader.frame(in: .global).midX
                }
            } label: {
                Image(tab.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                .frame(width: 30, height: 30)
                    .padding(selection == tab ? 10 : 0)
                    .background((selection == tab ? Color.theme.midnight : .clear).clipShape(Circle()))
                    .matchedGeometryEffect(id: tab, in: animation)
                    
                    .offset(x:  selection == tab ? (xAxis - xAxis - 10) : 0 ,
                            y: selection == tab ? -40 : 0)
                   
            }
            .onAppear(perform: {
                if tab.iconName == tabItems[1].iconName {
                    self.xAxis = reader.frame(in: .global).midX
                }
            })
        }
        .padding(.top)
        .foregroundColor(selection == tab ? Color.theme.pink : Color.theme.primaryText)
        .frame(width: 30, height: 30)
        .frame(maxWidth:.infinity)
    }
    
}


public struct TabBarItem: Hashable {
    let iconName: String
    let title: String
}


struct CurveShape: Shape {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get{return xAxis}
        set{xAxis = newValue}
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }
    }
}
