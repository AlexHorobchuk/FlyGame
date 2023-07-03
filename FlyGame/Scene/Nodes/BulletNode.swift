//
//  BulletNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/20/23.
//

import SpriteKit

final class BulletNode: SKSpriteNode {
    
    var radius: CGFloat = 5
    var angle: CGFloat? = nil
    
    init() {
        let texture = SKTexture(image: UIImage(named: ImageGenerator.fire.rawValue)!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.zPosition = 2
        let ratio = radius * 2 / self.size.width
        self.setScale(ratio)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.bullet
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicCategory.obstacle | PhysicCategory.boundry
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func setUpEmitter(target: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "Bullet")!
        
        emitter.zPosition = 1
        emitter.targetNode = target
        self.addChild(emitter)
    }
    
    func shootInDirection(direction: CGFloat) {
        let targetX = cos(direction) * 1200
        let targetY = sin(direction) * 1200
        
        let shootAction = SKAction.move(by: CGVector(dx: targetX, dy: -targetY), duration: 2)
        let removeAction = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([shootAction, removeAction])
        self.run(sequence)
        
    }
}
