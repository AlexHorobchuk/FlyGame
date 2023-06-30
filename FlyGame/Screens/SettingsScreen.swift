//
//  SettingsView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct SettingsScreen: View {
    
    @Binding var isShowingSettings: Bool
    
    @State var musicOn: Bool = UserDefaultsManager.shared.isMusicEnabled
    @State var soundOn: Bool = UserDefaultsManager.shared.isSoundEnabled
    @State var vibrationOn: Bool = UserDefaultsManager.shared.isVibrationEnabled
    
    
    var body: some View {
        
        VStack {
            ZStack {
                CustomView(image: ImageGenerator.settingsBack.rawValue)
                
                VStack {
                    
                    VStack(spacing: 12) {
                        
                        Spacer()
                        
                        HStack {
                            Text("Music")
                                .font(.custom("GlassAntiqua-Regular", size: 18))
                            
                            Spacer()
                            
                            Button(action: {
                                SoundManager.shared.playSound(for: .click)
                                UserDefaultsManager.shared.isMusicEnabled.toggle()
                                MusicManager.shared.playBackgroundMusic()
                                musicOn.toggle()
                            }) {
                                ToggleButton(isOn: $musicOn)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        HStack {
                            Text("Sound")
                                .font(.custom("GlassAntiqua-Regular", size: 18))
                            
                            Spacer()
                            
                            Button(action: {
                                UserDefaultsManager.shared.isSoundEnabled.toggle()
                                SoundManager.shared.playSound(for: .click)
                                soundOn.toggle()
                            }) {
                                ToggleButton(isOn: $soundOn)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        HStack {
                            Text("Vibration")
                                .font(.custom("GlassAntiqua-Regular", size: 18))
                            
                            Spacer()
                            
                            Button(action: {
                                UserDefaultsManager.shared.isVibrationEnabled.toggle()
                                VibrationManager.shared.vibrate(for: .medium)
                                SoundManager.shared.playSound(for: .click)
                                vibrationOn.toggle()
                            }) {
                                ToggleButton(isOn: $vibrationOn)
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        Link(destination: URL(string: "https://docs.google.com/document/d/1XihqPI_flJmz8zjsL92yKhxG2fPhUdScP2nUy1y6KaU/edit?usp=sharing")!) {
                            Text("PRIVACY POLICY")
                                .foregroundColor(.black)
                                .font(.custom("GlassAntiqua-Regular", size: 20))
                                .lineLimit(1)
                                .minimumScaleFactor(0.8)
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            SoundManager.shared.playSound(for: .click)
                        })
                    }
                    .padding(.bottom)
                    
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        isShowingSettings = false
                    }) {
                        CustomView(image: ImageGenerator.ok.rawValue)
                            .frame(height: UIScreen.main.bounds.height * 0.12)
                    }
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 10)
                .frame(width: UIScreen.main.bounds.width * 0.20)
            }
            .frame(height: UIScreen.main.bounds.height * 0.85)
        }
        .frame(maxWidth: UIScreen.main.bounds.width ,
               maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(isShowingSettings: .constant(true))
    }
}
