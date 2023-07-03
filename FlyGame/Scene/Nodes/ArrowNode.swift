//
//  ArrowNode.swift
//  KingJohnie1
//
//  Created by Olha Dzhyhirei on 7/2/23.
//

import SpriteKit

class ArrowNode: SKSpriteNode {
    let width: CGFloat = 70
    
    init() {
        let texture = SKTexture(image: UIImage(named: "Arrow")!)
        super.init(texture: texture, color: .black, size: CGSize(width: width, height: 14))
        let ratio = width / self.size.width
        self.setScale(ratio)
        self.name = "Arrow"
        self.anchorPoint = .init(x: 0.08, y: 0.5)
        self.zPosition = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
