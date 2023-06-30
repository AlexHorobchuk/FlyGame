//
//  GameRoolsView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct GameRulesView: View {
    
    @ObservedObject var gameVM: GameVM
    
    @State var index = 0
    @State var timer: Timer?
    @State var rulesFinished = UserDefaultsManager.shared.showedInstruction
    @State var animate = false
    var counter = 0
    
    func runRules() {
        if index == text.count - 1 {
            rulesFinished = true
        } else {
            index += 1
        }
    }
    
    var text = [
        "To win the game, you need to complete two stages.",
        "In the first stage, you need to collect all the stars before entering the maze.",
        "In the second stage, you will be shown a map of the maze with the correct path to the cup, which you need to find.",
        "But before grabbing the cup, you need to collect all the stars that are scattered throughout the maze.",
        "You also have the ability to shoot in order to defend yourself against monsters and meteors."
    ]
    
    var body: some View {
        ZStack {
            VStack {
                if !rulesFinished {
                    Text(text[index])
                        .foregroundColor(.white)
                        .font(.custom("GlassAntiqua-Regular", size: 25))
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: UIScreen.main.bounds.width * 04)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) {
                            gameVM.gameState = .starCollection
                            UserDefaultsManager.shared.showedInstruction = true
                        }
                    }) {
                        Text("Tap to continue")
                            .foregroundColor(.white)
                            .font(.custom("GlassAntiqua-Regular", size: 25))
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .scaleEffect(animate ? 1 : 1.3)
                            .frame(maxWidth: UIScreen.main.bounds.width * 0.3,
                                   maxHeight: UIScreen.main.bounds.height * 0.4)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                                    animate.toggle()
                                }
                            }
                    }
                }
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.3)
            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
        }
        .ignoresSafeArea(edges: .all)
        .frame(maxWidth: UIScreen.main.bounds.width ,
               maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
        .onAppear {
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1)) {
                    runRules()
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

struct GameRoolsView_Previews: PreviewProvider {
    static var previews: some View {
        GameRulesView(gameVM: GameVM(points: 1))
    }
}
