//
//  FlyGameApp.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

@main
struct FlyGameApp: App {
    
    @State var loading = true
    
    var body: some Scene {
        WindowGroup {
            if loading == true {
                LoaderView(loading: $loading)
                    .transition(.opacity)
            } else {
                StartScreen()
                    .onAppear {
                        MusicManager.shared.playBackgroundMusic()
                    }
            }
        }
    }
}
