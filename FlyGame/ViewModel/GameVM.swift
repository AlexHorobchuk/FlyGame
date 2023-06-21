//
//  GameVM.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

final class GameVM: ObservableObject {
    
    @Published var health: Int
    @Published var collectedStars: Int
    @Published var bullets: Int
    
    var starsQuontity: Int
    var mapGenerator: MapGenerator
    var logic: GameLogicService?
    
    init (points: Int) {
        self.starsQuontity = points
        self.collectedStars = 0
        self.bullets = points * 2
        self.health = 100
        self.mapGenerator = MapGenerator()
    }
    
    func getMap() -> [[MapCel]] {
        return mapGenerator.makeMap(starsQuantity: starsQuontity)
    }
    
    func shoot() {
        if bullets > 0 {
            logic?.shoot()
            bullets -= 1
        }
    }
    
    func gotStar() {
        collectedStars += 1
    }
    
    func hitLabirint() {
        
    }
    
    func playerAttacked() {
        withAnimation(.easeInOut(duration: 1.0)) {
            health -= 10
        }
    }
}
