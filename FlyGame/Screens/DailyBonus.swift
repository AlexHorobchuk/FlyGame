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
    
    var didReciveBonus =  UserDefaultsManager.shared.didRecieveBonus
    
    var body: some View {
        
        VStack {
            
            Text("BONUS")
                .font(.custom("GlassAntiqua-Regular", size: 32))
                .foregroundColor(.white)
                .padding(.top, UIScreen.main.bounds.height * 0.1)
            
            Spacer()
            
            ZStack {
                if didReciveBonus {
                    CustomView(image: ImageGenerator.rules.rawValue)
                }
                else {
                    CustomView(image: ImageGenerator.bonus.rawValue)
                }
                VStack {
                    
                    if didReciveBonus {
                        GeometryReader { geometry in
                            Text("You have received your bonus today. Come back tomorrow.")
                                .font(.custom("GlassAntiqua-Regular", size: 24))
                                .multilineTextAlignment(.center)
                                .lineLimit(6)
                                .minimumScaleFactor(0.5)
                                .padding(30)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: geometry.size.width)
                        }
                    }
                    
                    Spacer ()
                    
                    if !didReciveBonus {
                        Text("+\(progress.getDailyBonus())")
                            .font(.custom("GlassAntiqua-Regular", size: 30))
                    }
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        isShowingBonus = false
                    }) {
                        CustomView(image: ImageGenerator.ok.rawValue)
                            .frame(height: UIScreen.main.bounds.height * 0.12)
                            .offset(x: UIScreen.main.bounds.width * 0.01,
                                    y: didReciveBonus ? -UIScreen.main.bounds.width * 0.01 : 0)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.6)
            .fixedSize()
            
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width ,
               maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
    }
}

struct DaylyBonus_Previews: PreviewProvider {
    static var previews: some View {
        DailyBonus( progress: ProgressVM(), isShowingBonus: .constant(false))
    }
}
