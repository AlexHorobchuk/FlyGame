//
//  BulletIcon.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SwiftUI

struct BulletIcon: View {
    
    var bullets: Int
    
    var body: some View {
        HStack(spacing: -10) {
            Image(ImageGenerator.fire.rawValue)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.08,
                       maxHeight: UIScreen.main.bounds.height * 0.08)
            HStack(spacing: 2) {
                Text("x")
                    .font(.system(size: 23, weight: .bold))
                
                Text("\(bullets)")
                    .font(.system(size: 26, weight: .heavy))
            }
            .foregroundColor(.white)
        }
        .foregroundColor(Color.black.opacity(0.6))
            
    }
}

struct BulletIcon_Previews: PreviewProvider {
    static var previews: some View {
        BulletIcon(bullets: 10)
    }
}
