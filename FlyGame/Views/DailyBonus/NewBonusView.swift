//
//  NewBonus.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/26/23.
//

import SwiftUI

struct NewBonusView: View {
    
    var bonusAmount: Int
    
    var body: some View {
        
        Text("Your Bonus is")
        
        Text("\(bonusAmount)")
    }
}

struct NewBonus_Previews: PreviewProvider {
    static var previews: some View {
        NewBonusView(bonusAmount: 100)
    }
}
