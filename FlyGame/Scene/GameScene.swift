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
        self.addChild(pointer)
        setupMap()
        viewModel.mover = self
        setupCamera()
    }
    
    func findClosestStar() -> StartNode? {
        guard let player = getPlayer() else { return nil }
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
    
    func setUpPointer() {
        guard let star = findClosestStar() else { return pointer.isHidden = true }
        if cameraNode.isNodeInCamera(node: star) {
            pointer.isHidden = true
        }
        else {
            pointer.isHidden = false
            pointer.pointTowards(center: cameraNode.position, nodePosition: star.position, sceneSize: self.size)
        }
    }
    
    func setupMap() {
        let nodes = mapFactory.setupMap(map: viewModel.getMap())
        
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
        guard let player = getPlayer() else { return }
        let cameraConstraint = SKConstraint.distance(SKRange(constantValue: 0), to: player)
        cameraNode.constraints = [cameraConstraint]
    }
    
    override func update(_ currentTime: TimeInterval) {
        setUpPointer()
    }
}
