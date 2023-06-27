//
//  StartScreen.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct StartScreen: View {
    
    @State var showingSettings = false
    @State var showingDailyBonus = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination:
                                GameScreen(gameVM: GameVM(points: Int.random(in: 7..<12)))) {
                    Text("Play Game")
                        .frame(width: 120, height: 50)
                        .background(Color.red)
                        .padding()
                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    SoundManager.shared.playSound(for: .click)
                                })
                
                NavigationLink(destination:
                                ShopScreen()) {
                    Text("Shop")
                        .frame(width: 120, height: 50)
                        .background(Color.red)
                        .padding()
                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    SoundManager.shared.playSound(for: .click)
                                })
                
                Button(action: {
                    showingDailyBonus = true
                    SoundManager.shared.playSound(for: .click)
                } ) {
                    Text("Daily Bonus")
                        .frame(width: 120, height: 50)
                        .background(Color.red)
                        .padding()
                }
                
                Button(action: {
                    showingSettings = true
                    SoundManager.shared.playSound(for: .click)
                } ) {
                    Text("Settings")
                        .frame(width: 120, height: 50)
                        .background(Color.red)
                        .padding()
                }
                
                .fullScreenCover(isPresented: $showingSettings) {
                    SettingsScreen(isShowingSettings: $showingSettings)
                        .clearModalBackground()
                }
                
                .fullScreenCover(isPresented: $showingDailyBonus) {
                    DailyBonus(isShowingBonus: $showingDailyBonus)
                        .clearModalBackground()
                }
            }
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
