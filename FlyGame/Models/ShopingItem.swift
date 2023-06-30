//
//  Shopingitem.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/26/23.
//

import Foundation

enum ShopItems: String, CaseIterable {
    case one = "Back1",
         two = "Back2",
         three = "Back3"
    
    func getShopingItem() -> ShopingItem {
        switch self {
            
        case .one:
            return ShopingItem(price: 500, name: "Back1", image: "Back1Item")
        case .two:
            return ShopingItem(price: 500, name: "Back2", image: "Back2Item")
        case .three:
            return ShopingItem(price: 500, name: "Back3", image: "Back3Item")
        }
    }
}

struct ShopingItem {
    
    var id = UUID()
    var price: Int
    var name: String
    var image: String
    
}
