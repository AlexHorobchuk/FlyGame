//
//  ToggleButton.swift
//  KingJohnie1
//
//  Created by Olha Dzhyhirei on 6/29/23.
//

import SwiftUI

struct ToggleButton: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        
        Image(isOn ? ImageGenerator.settingsOn.rawValue :
                ImageGenerator.settingsOff.rawValue)
            .resizable()
            .scaledToFit()
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton(isOn: .constant(true))
    }
}
