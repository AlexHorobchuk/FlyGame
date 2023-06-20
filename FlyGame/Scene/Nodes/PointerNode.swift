//
//  PointerNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

class PointerNode: SKShapeNode {
    
    var radius: CGFloat = 25
    
    override init() {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.fillTexture = SKTexture(image: UIImage(systemName: "arrow.up.circle.fill")!)
        self.fillColor = SKColor.red
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
