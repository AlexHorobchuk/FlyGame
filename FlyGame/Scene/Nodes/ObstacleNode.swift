//
//  ObstacleNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class ObstacleNode: SKShapeNode {
    
    var radius: CGFloat = 20
    
    init(position: CGPoint) {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        self.position = position
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.fillColor = SKColor(.pink)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
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
}
