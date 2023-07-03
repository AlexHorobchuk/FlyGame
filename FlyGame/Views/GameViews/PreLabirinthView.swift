//
//  PreLabirinthView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/22/23.
//

import SwiftUI

struct PreLabirinthView: View {
    
    @State var animate = true
    
    var maze: [[MapCell]]
    var correctmaze: [(Int, Int)]?
    var action: (()->())?
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.4))
                .ignoresSafeArea()
            
            VStack(spacing: -10) {
                MazeMapView(maze: maze, correctmaze: correctmaze ?? [(0, 0)])
                
                Button(action: {
                    SoundManager.shared.playSound(for: .click)
                    action?()
                }) {
                    CustomView(image: ImageGenerator.ok.rawValue)
                        .frame(width: 70, height: 60)
                        .scaleEffect(animate ? 1 : 0.8)
                        .offset(y: 20)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct PreLabirinthView_Previews: PreviewProvider {
    static var previews: some View {
        PreLabirinthView(maze: MazeGenerator().maze)
    }
}
