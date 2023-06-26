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
                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("Music")
                                
                                Spacer()
                                
                                Button(action: {
                                    SoundManager.shared.playSound(for: .click)
                                    UserDefaultsManager.shared.isMusicEnabled.toggle()
                                    MusicManager.shared.playBackgroundMusic()
                                    musicOn.toggle()
                                }) {
                                    Text(musicOn ? "ON" : "OFF")
                                }
                            }
                            
                            HStack {
                                Text("Sound")
                                
                                Spacer()
                                
                                Button(action: {
                                    UserDefaultsManager.shared.isSoundEnabled.toggle()
                                    SoundManager.shared.playSound(for: .click)
                                    soundOn.toggle()
                                }) {
                                    Text(soundOn ? "ON" : "OFF")
                                }
                            }
                            
                            HStack {
                                Text("Vibration")
                                
                                Spacer()
                                
                                Button(action: {
                                    UserDefaultsManager.shared.isVibrationEnabled.toggle()
                                    VibrationManager.shared.vibrate(for: .medium)
                                    SoundManager.shared.playSound(for: .click)
                                    vibrationOn.toggle()
                                }) {
                                    Text(vibrationOn ? "ON" : "OFF")
                                }
                            }
                            
                            Link(destination: URL(string: "https://docs.google.com/document/d/1XihqPI_flJmz8zjsL92yKhxG2fPhUdScP2nUy1y6KaU/edit?usp=sharing")!) {
                                Text("PRIVACY POLICY")
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                SoundManager.shared.playSound(for: .click)
                            })
                        }
                    }
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        isShowingSettings = false
                    }) {
                        Text("Done")
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 10)
                .fixedSize()
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.65, maxHeight: UIScreen.main.bounds.height * 0.75)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .ignoresSafeArea(edges: .top)
        }
        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(isShowingSettings: .constant(true))
    }
}
