//
//  StartScreen.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct StartScreen: View {
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            NavigationLink(destination: GameScreen(gameVM: GameVM(points: Int.random(in: 7..<11)))) {
                Text("Play Game")
            }
            
            NavigationLink(destination: ShopScreen()) {
                Text("Shop")
            }
            
            
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
