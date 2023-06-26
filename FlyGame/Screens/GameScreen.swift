//
//  ContentView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

struct GameScreen: View {
    
    @StateObject var gameVM = GameVM(points: 1)
    
    var body: some View {
        
        ZStack {
            
            if gameVM.gameState != .gameOver && gameVM.gameState != .preGame {
                GeometryReader { gr in
                    if gameVM.gameState != .labirinth {
                        GameSpriteView(viewModel: gameVM, size: gr.size)
                            .frame(width: gr.size.width, height: gr.size.height)
                            .allowsHitTesting(false)
                            .transition(.opacity)
                    }
                    else {
                        LabirinthSpriteView(viewModel: gameVM, size: gr.size)
                            .frame(width: gr.size.width, height: gr.size.height)
                            .allowsHitTesting(false)
                            .transition(.opacity)
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                GameView(gameVM: gameVM)
            }
            
            else if gameVM.gameState == .gameOver {
                GameOverView()
            }
            
            else {
                GameRulesView()
            }
            
            
        }
        .fullScreenCover(item: $gameVM.alert) { alert in
            AlertView(alertItem: alert, action: {
                gameVM.alert = nil
                gameVM.logic?.unpause()
            })
            .clearModalBackground()
            .onAppear { gameVM.logic?.pause() }
        }
        
        .fullScreenCover(isPresented: $gameVM.isShowingLabirinth) {
            PreLabirinthView(maze: gameVM.getMap(type: .labirinth),
                             correctmaze: gameVM.mazeGenerator.findPathFromStartToFinish(),
                             action: {
                gameVM.isShowingLabirinth = false
                gameVM.gameState = .labirinth
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
    }
}
