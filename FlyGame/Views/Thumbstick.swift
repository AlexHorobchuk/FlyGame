//
//  Thumbstick.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

struct Thumbstick: View {
    
    @GestureState private var dragOffset = CGSize.zero
    
    @ObservedObject var game: GameVM
    
    let maxRadius = 35.0
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(.gray.opacity(0.9))
                .frame(width: 130, height: 130)
            
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 60, height: 60)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            let translation = value.translation
                            let distance = sqrt(pow(translation.width, 2) + pow(translation.height, 2))
                            
                            if distance <= maxRadius {
                                state = translation
                            } else {
                                let scaleFactor = maxRadius / distance
                                state = CGSize(width: translation.width * scaleFactor, height: translation.height * scaleFactor)
                            }
                            game.logic?.move(x: state.width, y: state.height)
                        }
                        .onEnded({ _ in game.logic?.move(x: 0, y: 0) }))
        }
    }
}

struct Thumbstick_Previews: PreviewProvider {
    static var previews: some View {
        Thumbstick(game: GameVM(points: 10))
    }
}
