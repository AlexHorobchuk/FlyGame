//
//  LoaderView.swift
//  KingJohnie1
//
//  Created by Olha Dzhyhirei on 7/2/23.
//

import SwiftUI

struct LoaderView: View {
    @State private var progress: Float = 0.0
    @Binding var loading: Bool
    
    var body: some View {
        ZStack {
            Image(UserDefaultsManager.shared.currentBackground)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .onAppear {
                    startProgressAnimation()
                }
            
            VStack {
                CustomView(image: "Logo")
                    .frame(height: UIScreen.main.bounds.width * 0.3)
                
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("Health1")))
                    .frame(width: 250, height: 2)
                    .scaleEffect(CGSize(width: 1, height: 4))
                    .padding()
                    .overlay(
                        CustomView(image: "Loader1").scaleEffect(x: 0.95))
            }
        }
    }
    
    private func startProgressAnimation() {
        let randomCount = Int.random(in: 3...6)
        let piece = 1.0 / Float(randomCount)
        
        for i in 1...randomCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.8...1.5) * Double(i)) {
                progress = Float(i) * piece
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.8...1.5) * Double(randomCount)) {
            withAnimation(.easeInOut(duration: 1.5)) {
                loading = false
            }
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(loading: .constant(false))
    }
}
