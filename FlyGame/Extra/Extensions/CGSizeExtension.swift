//
//  CGSizeExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

extension CGSize {
    
    static func * (size: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: size.width * scalar, height: size.height * scalar)
    }
}

extension SKTexture {
    func resize(to size: CGSize) -> SKTexture {
        let resizeAction = SKAction.resize(toWidth: size.width, height: size.height, duration: 0)
        let resizedNode = SKSpriteNode(texture: self)
        resizedNode.run(resizeAction)
        return resizedNode.texture!
    }
}
