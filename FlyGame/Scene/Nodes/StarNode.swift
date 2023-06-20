//
//  StarNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class StartNode: SKShapeNode {
    
    var radius: CGFloat = 30
    
    override init() {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
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
        self.fillColor = SKColor(.black)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        
        setUpObstacle()
    }
}
