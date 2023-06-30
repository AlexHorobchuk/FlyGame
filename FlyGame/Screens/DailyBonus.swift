//
//  DaylyBonus.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/26/23.
//

import SwiftUI

struct DailyBonus: View {
    
    @ObservedObject var progress : ProgressVM
    
    @Binding var isShowingBonus: Bool
    
    var didReciveBonus = UserDefaultsManager.shared.didRecieveBonus
    
    var body: some View {
        
        VStack {
            ZStack {
                VStack {
                    if didReciveBonus {
                        NoBonusView()
                    }
                    else {
                        NewBonusView(bonusAmount: progress.getDailyBonus())
                    }
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        isShowingBonus = false
                    }) {
                        Text("Done")
                    }
                    .padding(.vertical, 20)
                }
                .padding(.horizontal, 10)
                .fixedSize()
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.65, maxHeight: UIScreen.main.bounds.height * 0.75)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .ignoresSafeArea(edges: .top)
        }
        .frame(maxWidth: UIScreen.main.bounds.width , maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
    }
}

struct DaylyBonus_Previews: PreviewProvider {
    static var previews: some View {
        DailyBonus( isShowingBonus: .constant(true))
    }
}
