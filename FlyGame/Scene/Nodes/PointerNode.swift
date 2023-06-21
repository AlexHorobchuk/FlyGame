//
//  PointerNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

class PointerNode: SKSpriteNode {
    
    var radius: CGFloat = 25
    
    init() {
        let texture = SKTexture(image: UIImage(systemName: "arrow.up.circle.fill")!)
        super.init(texture: texture, color: .black, size: CGSize(width: radius * 2, height: radius * 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func pointTowards(center: CGPoint, nodePosition: CGPoint, sceneSize: CGSize) {
        let vectorToNode = CGVector(dx: nodePosition.x - center.x, dy: nodePosition.y - center.y)
        let angle = atan2(vectorToNode.dy, vectorToNode.dx)
        let pointerRotation = angle - CGFloat.pi / 2.0
        self.zRotation = pointerRotation
        
        let horizontalDistanceFromEdge: CGFloat = 100.0
        let verticalDistanceFromEdge: CGFloat = 50.0
        
        let targetPosition = CGPoint(
            x: center.x + cos(angle) * (sceneSize.width / 2.0 - horizontalDistanceFromEdge),
            y: center.y + sin(angle) * (sceneSize.height / 2.0 - verticalDistanceFromEdge)
        )
        self.position = targetPosition
    }
}
