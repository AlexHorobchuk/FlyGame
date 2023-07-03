//
//  ObstacleNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class ObstacleNode: SKSpriteNode {
    
    var radius: CGFloat = 20
    
    init(position: CGPoint) {
        let texture = SKTexture(image: UIImage(named: "Meteor\(Int.random(in: 1...4))")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        self.zPosition = 1
        self.position = position
        self.name = "Obstacle"
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        let ratio = radius * 2 / self.size.width
        self.setScale(ratio)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = PhysicCategory.obstacle
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicCategory.player | PhysicCategory.bullet | PhysicCategory.obstacle
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    private func createPath(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let startAngle = atan2(position.y - center.y, position.x - center.x)
        let endAngle = startAngle + CGFloat.pi * 2.0
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
    
    func flyAround(center: CGPoint) {
        let radius = center.distance(point: self.position)
        let path = createPath(center: center, radius: radius)
        let circularMotion = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, duration: 5.0)
        let repeatAction = SKAction.repeatForever(circularMotion)
        self.run(repeatAction)
    }
    
    func setUpEmitter(target: SKNode) {
        let emitter = SKEmitterNode(fileNamed: "Fire")!
        emitter.zPosition = -1
        emitter.targetNode = target
        self.addChild(emitter)
    }
    
    func gotShot() {
        self.physicsBody = nil
        let scaleAction = SKAction.scale(to: 0, duration: 1)
        let fadeAction = SKAction.fadeOut(withDuration: 1)
        let removeAction = SKAction.run { self.removeFromParent() }
        let groupAction = SKAction.group([scaleAction, fadeAction])
        
        self.run(SKAction.sequence([groupAction, removeAction]))
    }
}
