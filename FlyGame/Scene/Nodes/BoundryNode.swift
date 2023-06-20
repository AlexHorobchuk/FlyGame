//
//  BoundryNode.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

class BoundryNode: SKShapeNode {
    
    init(position: CGPoint, size: CGSize) {
        super.init()
        self.path = CGPath(rect: CGRect(origin: position, size: size), transform: nil)
        setUpNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpNode() {
        self.strokeColor = .red
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.path!)
        self.physicsBody?.isDynamic = false
    }
    
    
}
