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
            Rectangle()
                .fill(Color.white.opacity(0.4))
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Spacer()
                
                alertItem.title
                    .font(.system(size: 22, weight: .bold))
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                alertItem.message
                    .font(.system(size: 22, weight: .semibold))
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                Button(action: { action?() }) {
                alertItem.dismissButton
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                        .frame(width: 120, height: 50)
                }
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.red))
                
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.5,
                   maxHeight: UIScreen.main.bounds.height * 0.75)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.red, lineWidth: 2))
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alertItem: AlertConfirmation.notAllStarsCollected)
    }
}
