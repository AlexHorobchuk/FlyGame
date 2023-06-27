//
//  UserDefaultManager.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import Foundation

class UserDefaultsManager {
    
    static var shared = UserDefaultsManager()
    
    private let musicKey = "music"
    private let vibrationKey = "vibration"
    private let soundKey = "sound"
    private let money = "money"
    private let bonusRecieved = "bonus"
    private let shopItemKey = "item"
    private let currentBackgroundKey = "background"
    
    private init() {
        UserDefaults.standard.register(defaults: [
            musicKey : true,
            vibrationKey : true,
            soundKey : true,
            bonusRecieved : false,
            money : 0,
            shopItemKey : [String](),
            currentBackgroundKey : ""
            
        ])
    }
    
    var currentBackground: String {
        get { UserDefaults.standard.string(forKey: currentBackgroundKey) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: currentBackgroundKey) }
    }
    
    var shopItems: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "shopItem") ?? []
        }
        set {
            var items = shopItems
            items.append(contentsOf: newValue)
            UserDefaults.standard.set(items, forKey: "shopItem")
        }
    }
    
    var moneyCount: Int {
        get { UserDefaults.standard.integer(forKey: money) }
        set { UserDefaults.standard.set(newValue, forKey: money) }
    }
    
    var didRecieveBonus: Bool {
        get { UserDefaults.standard.bool(forKey: bonusRecieved) }
        set {
            UserDefaults.standard.set(newValue, forKey: bonusRecieved)
            MusicManager.shared.playBackgroundMusic()
        }
    }
    
    var isMusicEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: musicKey) }
        set {
            UserDefaults.standard.set(newValue, forKey: musicKey)
            MusicManager.shared.playBackgroundMusic()
        }
    }
    
    var isVibrationEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: vibrationKey) }
        set { UserDefaults.standard.set(newValue, forKey: vibrationKey) }
    }
    
    var isSoundEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: soundKey) }
        set { UserDefaults.standard.set(newValue, forKey: soundKey) }
    }
}
