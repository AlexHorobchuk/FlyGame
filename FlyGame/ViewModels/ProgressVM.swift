//
//  ProgressVm.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import Foundation

final class ProgressVM: ObservableObject {
    
    @Published var money: Int
    @Published var alert: AlertItem?
    
    var prize: Int?
    
    init () {
        self.money = UserDefaultsManager.shared.moneyCount
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
        }
    }
    
    func buy(item: ShopingItem) {
        if canBuy(item: item) {
            UserDefaultsManager.shared.moneyCount -= item.price
            update()
        } else {
            alert = AlertConfirmation.notEnoughFound
        }
    }
}
