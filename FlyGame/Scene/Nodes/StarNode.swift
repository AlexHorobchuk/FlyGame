//
//  StarNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class StartNode: SKSpriteNode {
    
    var radius: CGFloat = 30
    
    init() {
        let texture = SKTexture(image: UIImage(named: "Star")!)
        super.init(texture: texture, color: .clear, size: CGSize(width: radius * 2, height: radius * 2))
        self.name = "Star"
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpObstacle() {
        let nodeCount = Int.random(in: 5...10)
        let distanceBetweenNodes: CGFloat = 140.0
        let center = self.position
        
        for i in 0..<nodeCount {
            let angle = CGFloat(i) * (2.0 * CGFloat.pi / CGFloat(nodeCount))
            let xOffset = cos(angle) * distanceBetweenNodes
            let yOffset = sin(angle) * distanceBetweenNodes
            
            let nodePosition = CGPoint(x: center.x + xOffset, y: center.y + yOffset)
            let obstacleNode = ObstacleNode(position: nodePosition)
            obstacleNode.flyAround(center: center)
            self.addChild(obstacleNode)
        }
    }
    
    private func setUpNode() {
        let ratio = radius * 2 / self.size.width
        self.setScale(ratio)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicCategory.star
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = PhysicCategory.player
        setUpObstacle()
    }
    
    private func changeBitMask() {
        self.physicsBody = nil
        for children in self.children {
            children.physicsBody = nil
        }
    }
    
    func setParticle(target: SKNode) {
        for children in self.children {
            let obstacle = children as? ObstacleNode
            obstacle?.setUpEmitter(target: target)
        }
    }
    
    func captured() {
        changeBitMask()
        let scaleAction = SKAction.scale(to: 0, duration: 1)
        let fadeAction = SKAction.fadeOut(withDuration: 1)
        let removeAction = SKAction.run { self.removeFromParent() }
        let groupAction = SKAction.group([scaleAction, fadeAction])
        
        self.run(SKAction.sequence([groupAction, removeAction]))
    }
}
