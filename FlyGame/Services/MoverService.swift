//
//  MoverProtocol.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

protocol MoverService: AnyObject {
    
    func move(x: CGFloat, y: CGFloat)
}
