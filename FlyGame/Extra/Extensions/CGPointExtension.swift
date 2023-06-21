//
//  CGPointExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import Foundation

extension CGPoint {
    
    func distance(point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}
