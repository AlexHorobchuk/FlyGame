//
//  GameScene.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class GameScene: SKScene {
    
    var viewModel: GameVM
    
    init(viewModel: GameVM, size: CGSize) {
        self.viewModel = viewModel
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = SKColor(.blue)
        viewModel.mover = self
        addChild(PlayerNode(position: CGPoint(x: 0, y: 0)))
    }
    
    func getPlayer() -> PlayerNode? {
        guard let player = self.childNode(withName: "Player") else { return nil }
        return player as? PlayerNode
    }
}
