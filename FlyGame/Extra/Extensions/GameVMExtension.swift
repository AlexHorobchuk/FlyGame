//
//  GameVMExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

extension GameVM: Equatable {
    
    static func == (lhs: GameVM, rhs: GameVM) -> Bool {
        return lhs.points == rhs.points
    }
}
