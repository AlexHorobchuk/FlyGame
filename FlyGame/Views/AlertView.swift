//
//  AlertView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SwiftUI

struct AlertView: View {
    
    var alertItem: AlertItem
    var action: (()->())?
    
    var body: some View {
        
        ZStack {
            CustomView(image: ImageGenerator.rules.rawValue)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.5,
                       maxHeight: UIScreen.main.bounds.height * 0.75)
            
            VStack() {
                
                VStack {
                    GeometryReader { geometry in
                        alertItem.title
                            .font(.custom("GlassAntiqua-Regular", size: 22))
                            .lineLimit(4)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: geometry.size.width * 0.8)
                    }
                    
                    GeometryReader { geometry in
                        alertItem.message
                            .font(.custom("GlassAntiqua-Regular", size: 20))
                            .lineLimit(4)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(width: geometry.size.width * 0.8)
                    }
                }
                .padding(.top)
                .frame(maxWidth: UIScreen.main.bounds.width * 0.3,
                       maxHeight: UIScreen.main.bounds.height * 0.45)
                
                Spacer()
                
                HStack {
                    if alertItem.closeAction != nil {
                        Button(action: {
                            SoundManager.shared.playSound(for: .click)
                            alertItem.closeAction?()
                            action?()
                        }) {
                            ZStack {
                                CustomView(image: ImageGenerator.orangeBtn.rawValue)
                                    .frame(height: UIScreen.main.bounds.height * 0.12)
                                
                                Text("Yes")
                                    .foregroundColor(.white)
                                    .font(.custom("GlassAntiqua-Regular", size: 22))
                                    .frame(width: 120, height: 50)
                            }
                        }
                        
                        Spacer()
                    }
                    
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        action?()
                    }) {
                        ZStack {
                            CustomView(image: ImageGenerator.greenBtn.rawValue)
                                .frame(height: UIScreen.main.bounds.height * 0.12)
                            
                            alertItem.dismissButton
                                .foregroundColor(.white)
                                .font(.custom("GlassAntiqua-Regular", size: 22))
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width * 0.3,
                   maxHeight: UIScreen.main.bounds.height * 0.75)
        }
        .frame(maxWidth: UIScreen.main.bounds.width ,
               maxHeight: UIScreen.main.bounds.height)
        .background(Color.black.opacity(0.6))
        .ignoresSafeArea(edges: .all)
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alertItem: AlertConfirmation.notAllStarsCollected)
    }
}
