//
//  PlayerNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class PlayerNode: SKSpriteNode {
    
    var radius: CGFloat = 30
    var angle: CGFloat = 0
    var arrow: ArrowNode!
    
    init() {
        let texture = SKTexture(image: UIImage(named: "Player")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        let ratio = radius * 2 / self.size.width
        self.setScale(ratio)
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.name = "Player"
        self.zPosition = 3
        arrow = ArrowNode()
        arrow.position.y = self.position.y - (radius * 0.9)
        self.addChild(arrow)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = PhysicCategory.player
        self.physicsBody?.collisionBitMask = PhysicCategory.labyrinth | PhysicCategory.boundry
        self.physicsBody?.contactTestBitMask = PhysicCategory.obstacle | PhysicCategory.labyrinth | PhysicCategory.star
    }
    
    private func move(x: CGFloat, y: CGFloat) {
        self.physicsBody?.applyImpulse(CGVector(dx: x * 0.05, dy: -y * 0.08))
    }
    
    func moveWithDirection(x: CGFloat, y: CGFloat) {
        guard x != 0 && y != 0 else { return }
        let newAngle = atan2(y, x)
        move(x: x, y: y)
        angle = newAngle
        arrow?.zRotation = -angle
    }
    
    func attacked() {
        self.removeAllActions()
        
        let hideAction = SKAction.run { self.isHidden = true }
        let waitAction = SKAction.wait(forDuration: 0.1)
        let showAction = SKAction.run { self.isHidden = false}
        
        let toggleAction = SKAction.sequence([waitAction, hideAction, waitAction, showAction])
        let repeatAction = SKAction.repeat(toggleAction, count: 3)
        
        self.run(repeatAction)
    }
    
    func shoot() -> BulletNode {
        let bullet = BulletNode()
        
        let coordinatesX = (radius + bullet.radius) * cos(angle) + self.position.x
        let coordinatesY = self.position.y - (radius + bullet.radius) * sin(angle)
        let bulletPosition = CGPoint(x: coordinatesX, y: coordinatesY)
        bullet.position = bulletPosition
        
        bullet.shootInDirection(direction: angle)
        SoundManager.shared.playSound(for: .shot)
        return bullet
    }
}
