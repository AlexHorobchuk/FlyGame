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
            
            VStack {
                Spacer()
                
                HStack {
                    Thumbstick(game: gameVM)
                    
                    Spacer()
                    
                    Button(action: { }) {
                        ShootButton()
                    }
                }
                .padding(40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
