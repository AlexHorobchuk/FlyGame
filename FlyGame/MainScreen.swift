//
//  ContentView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject var gameVM = GameVM(points: 10)
    
    var body: some View {
        
        ZStack {
            GeometryReader { gr in
                GameSpriteView(viewModel: gameVM, size: gr.size)
                    .frame(width: gr.size.width, height: gr.size.height)
                    .allowsHitTesting(false)
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    HelthBar(health: gameVM.health)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        StarsIcon(allStars: gameVM.starsQuontity,
                                  collectedStars: gameVM.collectedStars)
                        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
