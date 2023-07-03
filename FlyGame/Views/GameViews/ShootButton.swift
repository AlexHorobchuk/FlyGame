//
//  ShootButton.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SwiftUI

struct ShootButton: View {
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.8))
                .frame(width: 80, height: 80)
            
            Image(ImageGenerator.fire.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .foregroundColor(Color.black.opacity(0.5))
        }
    }
}

struct ShootButton_Previews: PreviewProvider {
    static var previews: some View {
        ShootButton()
    }
}
