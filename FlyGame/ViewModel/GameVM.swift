//
//  GameVM.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

final class GameVM: ObservableObject {
    
    @Published var health = 100
    @Published var isShowingLabirinth = false
    @Published var gameState: GameState
    @Published var alert: AlertItem?
    @Published var collectedStars: Int
    @Published var bullets: Int
    
    var starsQuontity: Int
    var mapGenerator = MapGenerator()
    var mazeGenerator = MazeGenerator()
    var logic: GameLogicService?
    
    init (points: Int) {
        self.starsQuontity = points
        self.collectedStars = 0
        self.bullets = points * 2
        self.gameState = .labirinth
    }
    
    func getMap() -> [[MapCell]] {
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
        if collectedStars == starsQuontity {
            gameState = .lookingForLabirinth
        }
    }
    
    func hitLabirint() {
        guard starsQuontity == collectedStars else { return alert = AlertConfirmation.notAllStarsCollected }
        gameState = .labirinth
        
    }
    
    func playerAttacked() {
        guard health > 0 else { return }
        withAnimation(.easeInOut(duration: 1.0)) {
            health -= 10
        }
    }
}
