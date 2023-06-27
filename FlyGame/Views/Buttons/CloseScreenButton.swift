//
//  SwiftUIView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/26/23.
//

import SwiftUI

struct CloseScreenButton: View {
    
    var body: some View {
        
        Image(systemName: "x.circle.fill")
            .foregroundColor(.red)
            .font(.system(size: 32))
    }
}

struct CloseScreenButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseScreenButton()
    }
}
