//
//  MapFactory.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

class MapFactory {
    
    private let spacing = 700
    
    private func createNode(cell: MapCel) -> SKNode? {
        switch cell {
        case .empty:
            return nil
        case .star:
            return StartNode()
        case .labirint:
            return LabirinthNode()
        }
    }
    
    private func getBoundary(map: [[MapCel]]) -> SKShapeNode {
        let size = map.count * spacing
        let boundaryOrigin = CGPoint(x: -spacing / 2, y: -spacing / 2)
        let boundaryNode = BoundryNode(position: boundaryOrigin, size: CGSize.init(width: size, height: size))
        
        return boundaryNode
    }
    
    func setupMap(map: [[MapCel]]) -> [SKNode] {
        var allNodes = [SKNode]()
        
        for (row, val) in map.enumerated() {
            for (col, cell) in val.enumerated() {
                guard let node = createNode(cell: cell) else { continue }
                
                let adjustmentX = Int.random(in: -100...100)
                let adjustmentY = Int.random(in: -100...100)
                
                let position = CGPoint(x: (spacing * col) + adjustmentX, y: (spacing * row) + adjustmentY)
                node.position = position
                allNodes.append(node)
                if cell == .labirint {
                    let player = PlayerNode(position: CGPoint(x: position.x, y: position.y - 100))
                    allNodes.append(player)
                }
            }
        }
        
        let boundryNode = getBoundary(map: map)
        allNodes.append(boundryNode)
        return allNodes
    }
}
