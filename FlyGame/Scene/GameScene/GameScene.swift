//
//  GameScene.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import SpriteKit

final class GameScene: SKScene {
    
    var viewModel: GameVM
    var cameraNode = SKCameraNode()
    var mapFactory = MapFactory()
    var pointer = PointerNode()
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
        self.addChild(pointer)
        setupMap()
        player = getPlayer()
        viewModel.logic = self
        setupCamera()
        physicsWorld.contactDelegate = self
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
    
    func pointerConfig(node: SKNode) {
        if cameraNode.isNodeInCamera(node: node) {
            pointer.isHidden = true
        }
        else {
            pointer.isHidden = false
            pointer.pointTowards(center: cameraNode.position, nodePosition: node.position, sceneSize: self.size)
        }
    }
    
    func setUpPointer() {
        if viewModel.gameState != .lookingForLabirinth {
            guard let star = findClosestStar() else { return }
            pointerConfig(node: star)
        }
        else {
            guard let labirinth = self.childNode(withName: "Labirinth") else { return }
            pointerConfig(node: labirinth)
        }
    }
    
    func setupMap() {
        let nodes = mapFactory.setupMap(map: viewModel.getMap(type: .starCollecting), mapType: .starCollecting)
        
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
    
    override func update(_ currentTime: TimeInterval) {
        setUpPointer()
    }
}
