//
//  AlertItem.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Text
    var closeAction: (()->())?
}


struct AlertConfirmation {
    
    static let goBack = AlertItem(title: Text("Do you want to leave?"),
                                  message: Text("Game results will not be saved"),
                                  dismissButton: Text("No"))
    
    static let notEnoughFound = AlertItem(title: Text("Can`t buy item"),
                                          message: Text("You don`t have enough money to buy this item"),
                                          dismissButton: Text("Close"))
    
    static let notAllStarsCollected = AlertItem(title: Text("You Didn`t collet all stars"),
                                                message: Text("Please come back when you have collected all the stars."),
                                                dismissButton: Text("Close"))
}
