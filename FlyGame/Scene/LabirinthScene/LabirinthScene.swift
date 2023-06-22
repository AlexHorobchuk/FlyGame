//
//  LabirinthScene.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SpriteKit

final class LabirinthScene: SKScene {
    
    var viewModel: GameVM
    var cameraNode = SKCameraNode()
    var mapFactory = MapFactory()
    var player: PlayerNode!
    
    init(viewModel: GameVM, size: CGSize) {
        self.viewModel = viewModel
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = SKColor(.white)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
    }
    
    func findClosestStar() -> StartNode? {
        let stars = self.children.compactMap { $0 as? StartNode }
        var closestStar: StartNode?
        var closestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for star in stars {
            let distance = star.position.distance(point: player.position)
            if distance < closestDistance {
                closestDistance = distance
                closestStar = star
            }
        }
        return closestStar
    }
    
    func setupMap() {
        let nodes = mapFactory.setupMap(map: viewModel.getMap(), mapType: .labirinth)
        
        for node in nodes {
            self.addChild(node)
            guard let star = node as? StartNode else { continue }
            star.setParticle(target: self)
        }
    }
    
    func getPlayer() -> PlayerNode? {
        guard let player = self.childNode(withName: "Player") else { return nil }
        return player as? PlayerNode
    }
    
    func setupCamera() {
        self.addChild(cameraNode)
        self.camera = cameraNode
        let cameraConstraint = SKConstraint.distance(SKRange(constantValue: 0), to: player)
        cameraNode.constraints = [cameraConstraint]
    }
}
