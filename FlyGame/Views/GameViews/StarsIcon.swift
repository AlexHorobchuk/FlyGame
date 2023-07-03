//
//  StarsIcon.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SwiftUI

struct StarsIcon: View {
    
    var allStars: Int
    var collectedStars: Int
    
    var body: some View {
        HStack(spacing: -10) {
            Image(ImageGenerator.star.rawValue)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.08,
                       maxHeight: UIScreen.main.bounds.height * 0.08)
            HStack(spacing: 2) {
                Text("\(allStars)")
                    .font(.system(size: 26, weight: .heavy))
                
                Text("/")
                    .font(.system(size: 26, weight: .heavy))
                
                Text("\(collectedStars)")
                    .font(.system(size: 26, weight: .heavy))
            }
            .foregroundColor(.white)
        }
        .foregroundColor(Color.black.opacity(0.6))
    }
}

struct StarsIcon_Previews: PreviewProvider {
    static var previews: some View {
        StarsIcon(allStars: 10, collectedStars: 5)
    }
}
