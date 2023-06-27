//
//  Shopingitem.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/26/23.
//

import Foundation

enum ShopItems: CaseIterable {
    case one, two, three
    
    func getShopingItem() -> ShopingItem {
        switch self {
            
        case .one:
            return ShopingItem(price: 500, name: "One")
        case .two:
            return ShopingItem(price: 500, name: "Two")
        case .three:
            return ShopingItem(price: 500, name: "Three")
        }
    }
}

struct ShopingItem {
    
    var id = UUID()
    var price: Int
    var name: String
    
}
