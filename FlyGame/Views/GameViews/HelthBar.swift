//
//  HelthBar.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SwiftUI

struct HelthBar: View {
    
    var health: Int
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.gray)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.red)
                    .frame(width: geometry.size.width * CGFloat(health) * 0.01, height: geometry.size.height)
            }
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(.white, lineWidth: 2))
            
        }
        .opacity(0.8)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.25,
               maxHeight: UIScreen.main.bounds.height * 0.06)
    }
}

struct HelthBar_Previews: PreviewProvider {
    static var previews: some View {
        HelthBar(health: 40)
    }
}
