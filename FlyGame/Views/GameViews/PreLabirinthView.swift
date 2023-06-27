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
            
            VStack {
                MazeMapView(maze: maze, correctmaze: correctmaze ?? [(0, 0)])
                
                Button(action: { action?() }) {
                    Text("Tap to continue")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 220, height: 55)
                        .background(Color.red)
                        .clipShape(Capsule())
                        .scaleEffect(animate ? 1 : 0.8)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 2))
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
