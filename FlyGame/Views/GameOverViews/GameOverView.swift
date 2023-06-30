//
//  GameOverView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct GameOverView: View {
    
    var didWin: Bool
    var action: (()->())?
    var progress: ProgressVM
    
    var body: some View {
        VStack {
            Spacer()
            
            Text( didWin ? "You won" : "You lost")
                .font(.custom("GlassAntiqua-Regular", size: 30))
                .foregroundColor(.white)
            
            Spacer()
            
            Text("Your prize is:")
                .font(.custom("GlassAntiqua-Regular", size: 24))
                .foregroundColor(.white)
            
            Spacer()
            
            Text("\(progress.getPrize(didWin: didWin))").font(.custom("GlassAntiqua-Regular", size: 28))
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: { action?() }) {
                CustomView(image: ImageGenerator.menuBtn.rawValue)
                    .frame(width: 140)
            }
            
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SoundManager.shared.playSound(for: didWin ? .won : .loose)
            }
        }
        .transition(.opacity)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(didWin: true, progress: ProgressVM())
            .background(Color.black)
    }
}
