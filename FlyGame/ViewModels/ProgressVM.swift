//
//  ProgressVm.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import Foundation

class ProgressVM: ObservableObject {
    
    @Published var money: Int
    @Published var alert: AlertItem?
    
    init () {
        self.money = UserDefaultsManager.shared.moneyCount
    }
    
    func getPrize(didWin: Bool) -> Int {
        let prize = Int.random(in: (100...150))
        if didWin {
            UserDefaultsManager.shared.moneyCount += prize
            return prize
        }
        else {
            UserDefaultsManager.shared.moneyCount += prize / 4
            return prize / 4
        }
    }
    
    func buy() {
        
    }
}
