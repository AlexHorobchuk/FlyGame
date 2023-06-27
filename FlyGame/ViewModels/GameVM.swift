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
        self.gameState = .starCollection
    }
    
    func getMap(type: MapType) -> [[MapCell]] {
        if type == .starCollecting {
            return mapGenerator.makeMap(starsQuantity: starsQuontity)
        } else {
            return mazeGenerator.maze
        }
    }
    
    func shoot() {
        if bullets > 0 {
            logic?.shoot()
            bullets -= 1
        }
    }
    
    func gotTrophy() {
        withAnimation(.easeInOut(duration: 1.0)) {
            gameState = .gameOver
        }
    }
    
    func gotStar() {
        guard health > 0 else { return }
        collectedStars += 1
        if collectedStars == starsQuontity {
            withAnimation(.easeInOut(duration: 1.0)) {
                gameState = .lookingForLabirinth
            }
        }
    }
    
    func hitLabirint() {
        guard starsQuontity == collectedStars else { return alert = AlertConfirmation.notAllStarsCollected }
        withAnimation(.easeInOut(duration: 1.0)) { 
            isShowingLabirinth = true
        }
    }
    
    func playerAttacked() {
        guard health > 0 else { return }
        withAnimation(.easeInOut(duration: 1.0)) {
            health -= 10
            if health <= 0 {
                gameState = .gameOver
            }
        }
    }
    
    func didWin() -> Bool {
        gameState == .gameOver && health > 0
    }
}
