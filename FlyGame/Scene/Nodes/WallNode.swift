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
        let texture = SKTexture(image: UIImage(named: "Lab1")!)
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
        self.physicsBody?.categoryBitMask = PhysicCategory.boundry
        self.physicsBody?.collisionBitMask = PhysicCategory.player | PhysicCategory.obstacle
        self.physicsBody?.contactTestBitMask = PhysicCategory.bullet
    }
}
