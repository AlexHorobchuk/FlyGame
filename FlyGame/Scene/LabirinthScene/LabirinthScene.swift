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
        self.view?.allowsTransparency = true
        self.view?.backgroundColor = .clear
        backgroundColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        physicsWorld.contactDelegate = self
        
        setupMap()
        player = getPlayer()
        viewModel.logic = self
        setupCamera()
    }
    
    func setupMap() {
        let nodes = mapFactory.setupMap(map: viewModel.getMap(type: .labirinth),
                                        mapType: .labirinth,
                                        rightPath: viewModel.mazeGenerator.findPathFromStartToFinish())
        for node in nodes {
            self.addChild(node)
        }
    }
    
    func getPlayer() -> PlayerNode? {
        guard let player = self.childNode(withName: "Player") else { return nil }
        return player as? PlayerNode
    }
    
    func setupCamera() {
        self.addChild(cameraNode)
        self.camera = cameraNode
        cameraNode.setScale(0.8)
        let cameraConstraint = SKConstraint.distance(SKRange(constantValue: 0), to: player)
        cameraNode.constraints = [cameraConstraint]
    }
    
    func checkEnemies() {
        let enemies = self.children.compactMap { $0 as? EnemyNode }
        for node in enemies {
            if cameraNode.isEnemyInCamera(node: node) {
                node.follow(playerNode: player)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkEnemies()
    }
}
