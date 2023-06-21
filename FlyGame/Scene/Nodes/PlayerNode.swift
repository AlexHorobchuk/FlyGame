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
    var isMoving = false
    
    init(position: CGPoint) {
        let texture = SKTexture(image: UIImage(systemName: "face.smiling.inverse")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        self.position = position
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.name = "Player"
        self.zPosition = 3
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.player
        self.physicsBody?.collisionBitMask = PhysicCategory.labyrinth | PhysicCategory.boundry
        self.physicsBody?.contactTestBitMask = PhysicCategory.obstacle | PhysicCategory.labyrinth | PhysicCategory.star
    }
    
    private func move(x: CGFloat, y: CGFloat) {
        self.removeAllActions()
        let moveAction = SKAction.move(by: CGVector(dx: x * 8, dy: -y * 8), duration: 1)
        let continuousMove = SKAction.repeatForever(moveAction)
        self.run(continuousMove)
    }
    
    private func stayOnSport() {
        self.removeAllActions()
        isMoving = false
    }
    
    func moveWithDirection(x: CGFloat, y: CGFloat) {
        guard x != 0 && y != 0 else { return stayOnSport() }
        let newAngle = atan2(y, x)
         
        if !isMoving {
            isMoving = true
            move(x: x, y: y)
            angle = newAngle
        }
        else {
            if abs(newAngle - angle) >= 0.3 {
                move(x: x, y: y)
                angle = newAngle
            }
        }
    }
    
    func attacked() {
        
    }
    
    func shoot() -> BulletNode {
        let bullet = BulletNode()
        
        let coordinatesX = (radius + bullet.radius) * cos(angle) + self.position.x
        let coordinatesY = self.position.y - (radius + bullet.radius) * sin(angle)
        let bulletPosition = CGPoint(x: coordinatesX, y: coordinatesY)
        bullet.position = bulletPosition
        
        bullet.shootInDirection(direction: angle)
        return bullet
    }
}
