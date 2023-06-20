//
//  CameraExtension.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

extension SKCameraNode {
    
    func isNodeInCamera(node: SKNode) -> Bool {
        guard let scene = self.scene else {
            return false
        }
        
        let cameraPositionInScene = scene.convert(self.position, from: self.parent!)
        let nodePositionInScene = scene.convert(node.position, from: node.parent!)
        
        let cameraFrame = CGRect(origin: CGPoint(x: cameraPositionInScene.x - scene.size.width / 2, y: cameraPositionInScene.y - scene.size.height / 2), size: scene.size)
        
        return cameraFrame.contains(nodePositionInScene)
    }
}
