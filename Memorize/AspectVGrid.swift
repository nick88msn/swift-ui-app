//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Nicola Mastrandrea on 02/06/21.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView){
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    let width: CGFloat = 100
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: width, maximum: 200))]){
                ForEach(items){ item in
                    content(item).aspectRatio(aspectRatio,contentMode: .fit)
                }
            }
        }
    }
    
    
}

