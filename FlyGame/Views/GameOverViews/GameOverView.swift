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
            Text( didWin ? "You won" : "You lost")
            
            Text("Your prize is")
            
            Text("\(progress.getPrize(didWin: didWin))")
            
            Button(action: { action?() }) {
                Text("Done")
            }
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
    }
}
