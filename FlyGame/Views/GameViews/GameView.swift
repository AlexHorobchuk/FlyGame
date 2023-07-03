//
//  GameView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SwiftUI

struct GameView: View {
    
    @ObservedObject var gameVM: GameVM
    
    var showSettings: (()->())?
    var goBack: (()->())?
    
    var body: some View {
        
        VStack {
            HStack(alignment: .top, spacing: 50) {
                VStack {
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        goBack?()
                    }) {
                        CustomView(image: ImageGenerator.goBack.rawValue)
                            .frame(width: 45, height: 45)
                    }
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        showSettings?()
                    }) {
                        CustomView(image: ImageGenerator.settingsBtn.rawValue)
                            .frame(width: 45, height: 45)
                    }
                    
                }
                
                HelthBar(health: gameVM.health)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    StarsIcon(allStars: gameVM.starsQuontity,
                              collectedStars: gameVM.collectedStars)
                    BulletIcon(bullets: gameVM.bullets)
                    }
            }
            .padding(20)
            
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
        .frame(width: UIScreen.main.bounds.width * 0.95,
               height: UIScreen.main.bounds.height * 0.95 )
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameVM: GameVM(points: 10))
    }
}
