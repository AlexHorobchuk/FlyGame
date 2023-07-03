//
//  LabirinthNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

final class LabirinthNode: SKSpriteNode {
    
    var sideLength: CGFloat = 100
    var isMoving = false
    
    init() {
        let texture = SKTexture(image: UIImage(named: "Labirinth")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: sideLength, height: sideLength))
        self.position = position
        self.name = "Labirinth"
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.zPosition = 2
        let ratio = sideLength / self.size.width
        self.setScale(ratio)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sideLength, height: sideLength))
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicCategory.labyrinth
        self.physicsBody?.collisionBitMask = PhysicCategory.player
        self.physicsBody?.contactTestBitMask = PhysicCategory.player
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
}
