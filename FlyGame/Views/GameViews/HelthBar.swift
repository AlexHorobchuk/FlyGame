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
                    .fill(LinearGradient(colors: [Color("Health3"), Color("Health4") ], startPoint: .top, endPoint: .bottom))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(LinearGradient(colors: [Color("Health2"), Color("Health1") ], startPoint: .top, endPoint: .bottom))
                    .frame(width: geometry.size.width * CGFloat(health) * 0.01, height: geometry.size.height)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.25,
                   maxHeight: UIScreen.main.bounds.height * 0.05)
            
            HStack {
                CustomView(image: ImageGenerator.hart.rawValue)
                    .offset(x: -UIScreen.main.bounds.height * 0.095)
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.25,
                   maxHeight: UIScreen.main.bounds.height * 0.1)
        }
    }
}

struct HelthBar_Previews: PreviewProvider {
    static var previews: some View {
        HelthBar(health: 40)
    }
}
