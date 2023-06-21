//
//  CGSizeExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import Foundation

extension CGSize {
    
    static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }
}
