//
//  GameView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var gameVM: GameVM
    
    var body: some View {
        
        VStack {
            HStack {
                HelthBar(health: gameVM.health)
                
                Spacer()
                
                    VStack(alignment: .leading, spacing: 5) {
                        if gameVM.gameState == .starCollection {
                            StarsIcon(allStars: gameVM.starsQuontity,
                                      collectedStars: gameVM.collectedStars)
                        }
                        
                        BulletIcon(bullets: gameVM.bullets)
                    }
            }
            .padding(10)
            
            Spacer()
            
            HStack {
                Thumbstick(game: gameVM)
                
                Spacer()
                
                Button(action: { gameVM.shoot() }) {
                    ShootButton()
                }
            }
            .padding(10)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameVM: GameVM(points: 10))
    }
}
