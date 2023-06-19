//
//  PlayerNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class PlayerNode: SKShapeNode {
    
    var radius: CGFloat = 30
    var angle: CGFloat? = nil
    
    init(position: CGPoint) {
        super.init()
        self.path = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2), transform: nil)
        self.position = position
        self.name = "Player"
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.fillColor = SKColor(.green)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
    }
    
    private func move(x: CGFloat, y: CGFloat) {
        self.removeAllActions()
        let moveAction = SKAction.move(by: CGVector(dx: x * 10, dy: -y * 10), duration: 3)
        let continuousMove = SKAction.repeatForever(moveAction)
        self.run(continuousMove)
    }
    
    private func stayOnSport() {
        self.removeAllActions()
        self.angle = nil
    }
    
    func moveWithDirection(x: CGFloat, y: CGFloat) {
        guard x != 0 && y != 0 else { return stayOnSport() }
        let newAngle = atan2(y, x)
         
        if angle == nil {
            move(x: x, y: y)
            angle = newAngle
        }
        else {
            if abs(newAngle - angle!) >= 0.3 {
                self.move(x: x, y: y)
                angle = newAngle
            }
        }
     }
}
