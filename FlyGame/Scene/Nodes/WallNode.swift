//
//  WallNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SpriteKit

final class WallNode: SKSpriteNode {
        
    var side: CGFloat = 100
    var angle: CGFloat = 0
    
    init() {
        let color = UIColor.black
        let texture = SKTexture(image: UIImage(systemName: "square")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: side, height: side))
        self.position = position
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: side, height: side))
        self.physicsBody?.isDynamic = false
    }
}
