//
//  ProgressVm.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import Foundation
import SwiftUI

final class ProgressVM: ObservableObject {
    
    @Published var money: Int
    @Published var alert: AlertItem?
    @Published var currentBackground: String
    @Published var allBackgrounds: [String]
    
    var prize: Int?
    
    init () {
        self.money = UserDefaultsManager.shared.moneyCount
        self.currentBackground = UserDefaultsManager.shared.currentBackground
        self.allBackgrounds = UserDefaultsManager.shared.shopItems
    }
    
    private func canBuy(item: ShopingItem) -> Bool {
        guard item.price <= money else { return false }
        return true
    }
    
    func getPrize(didWin: Bool) -> Int {
        guard prize == nil else { return prize! }
        let result = Int.random(in: (100...150))
        if didWin {
            UserDefaultsManager.shared.moneyCount += result
            prize = result
            return result
        }
        else {
            UserDefaultsManager.shared.moneyCount += result / 4
            prize = result
            return result / 4
        }
    }
    
    func getDailyBonus() -> Int {
        UserDefaultsManager.shared.didRecieveBonus = true
        return getPrize(didWin: true)
    }
    
    func update() {
        DispatchQueue.main.async {
            self.money = UserDefaultsManager.shared.moneyCount
            self.allBackgrounds = UserDefaultsManager.shared.shopItems
            self.currentBackground = UserDefaultsManager.shared.currentBackground
        }
    }
    
    func buy(item: ShopingItem) {
        withAnimation(.easeInOut(duration: 1)) {
            if allBackgrounds.contains(where: { $0 == item.name } ) {
                UserDefaultsManager.shared.currentBackground = item.name
                update()
            }
            else {
                if canBuy(item: item) {
                    UserDefaultsManager.shared.moneyCount -= item.price
                    UserDefaultsManager.shared.currentBackground = item.name
                    UserDefaultsManager.shared.shopItems = [item.name]
                    update()
                } else {
                    alert = AlertConfirmation.notEnoughFound
                }
            }
        }
    }
}
