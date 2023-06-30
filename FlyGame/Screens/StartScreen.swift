//
//  StartScreen.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct StartScreen: View {
    
    @StateObject var progress = ProgressVM()
    @State var showingSettings = false
    @State var showingDailyBonus = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Image(progress.currentBackground)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                VStack(spacing: 10) {
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            showingDailyBonus = true
                            SoundManager.shared.playSound(for: .click)
                        } ) {
                            CustomView(image: ImageGenerator.chest.rawValue)
                                .frame(height: UIScreen.main.bounds.height * 0.20)
                        }
                    }
                    
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width * 0.9,
                       height: UIScreen.main.bounds.height * 0.9)
                VStack {
                    ZStack {
                        
                        CustomView(image: ImageGenerator.menu.rawValue)
                        
                        VStack(spacing: 15) {
                            NavigationLink(destination:
                                            GameScreen(gameVM: GameVM(points: Int.random(in: 7..<12)))) {
                                CustomView(image: ImageGenerator.play.rawValue)
                                    .frame(height: UIScreen.main.bounds.height * 0.10)
                            }
                                            .simultaneousGesture(TapGesture().onEnded {
                                                SoundManager.shared.playSound(for: .click)
                                            })
                            
                            NavigationLink(destination:
                                            ShopScreen(progress: progress)) {
                                CustomView(image: ImageGenerator.shop.rawValue)
                                    .frame(height: UIScreen.main.bounds.height * 0.10)
                            }
                                            .simultaneousGesture(TapGesture().onEnded {
                                                SoundManager.shared.playSound(for: .click)
                                            })
                            
                            Button(action: {
                                showingSettings = true
                                SoundManager.shared.playSound(for: .click)
                            } ) {
                                CustomView(image: ImageGenerator.settings.rawValue)
                                    .frame(height: UIScreen.main.bounds.height * 0.10)
                            }
                        }
                        .offset(y: UIScreen.main.bounds.height * 0.02)
                    }
                }
                .frame(height: UIScreen.main.bounds.height * 0.85)
                .fullScreenCover(isPresented: $showingSettings) {
                    SettingsScreen(isShowingSettings: $showingSettings)
                        .clearModalBackground()
                }
                
                .fullScreenCover(isPresented: $showingDailyBonus) {
                    DailyBonus(progress: progress, isShowingBonus: $showingDailyBonus)
                        .clearModalBackground()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
