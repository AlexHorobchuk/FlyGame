//
//  ContentView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

struct GameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var gameVM = GameVM(points: Int.random(in: 7...12))
    @StateObject var progress = ProgressVM()
    
    @State var isShowingSettings = false
    
    var body: some View {
        
        ZStack {
            Image(progress.currentBackground)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
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
                
                GameView(gameVM: gameVM,
                         showSettings: { isShowingSettings = true },
                         goBack: {
                    gameVM.alert = AlertConfirmation.goBack
                    gameVM.alert?.closeAction = { presentationMode.wrappedValue.dismiss() } })
            }
            
            else if gameVM.gameState == .gameOver {
                
                GameOverView(didWin: gameVM.didWin(),
                             action: { presentationMode.wrappedValue.dismiss() },
                             progress: progress)
                    .transition(.opacity)
            }
            
            else {
                GameRulesView(gameVM: gameVM)
                    .transition(.opacity)
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
            .clearModalBackground()
        }
        
        .fullScreenCover(isPresented: $isShowingSettings) {
            SettingsScreen(isShowingSettings: $isShowingSettings)
                .clearModalBackground()
                .onAppear { gameVM.logic?.pause() }
                .onDisappear { gameVM.logic?.unpause() }
            }
        
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen()
    }
}
