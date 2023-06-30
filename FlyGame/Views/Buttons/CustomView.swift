//
//  CustomButton.swift
//  KingJohnie1
//
//  Created by Olha Dzhyhirei on 6/28/23.
//

import SwiftUI

struct CustomView: View {
    
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomView(image: "Chest")
    }
}
