//
//  MapFactory.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

class MapFactory {
    
    enum MapType {
        case labirinth, starCollecting
    }
    
    private let spacing = 700
    private let labirintSpacing = 100
    
    private func createNode(cell: MapCell) -> SKNode? {
        switch cell {
        case .empty:
            return nil
        case .star:
            return StartNode()
        case .labirint:
            return LabirinthNode()
        case .start:
            return PlayerNode()
        case .road:
            return nil
        case .wall:
            return WallNode()
        case .end:
            return TrophyNode()
        }
    }
    
    private func getBoundary(map: [[MapCell]]) -> SKShapeNode {
        let size = map.count * spacing
        let boundaryOrigin = CGPoint(x: -spacing / 2, y: -spacing / 2)
        let boundaryNode = BoundryNode(position: boundaryOrigin, size: CGSize.init(width: size, height: size))
        
        return boundaryNode
    }
    
    func setupMap(map: [[MapCell]], mapType: MapType) -> [SKNode] {
        var allNodes = [SKNode]()
        let spacing = mapType == .labirinth ? labirintSpacing : spacing
        
        for (row, val) in map.enumerated() {
            for (col, cell) in val.enumerated() {
                guard let node = createNode(cell: cell) else { continue }
                
                let adjustmentX = mapType == .labirinth ? 0 : Int.random(in: -100...100)
                let adjustmentY = mapType == .labirinth ? 0 : Int.random(in: -100...100)
                
                let position = CGPoint(x: (spacing * col) + adjustmentX, y: (spacing * row) + adjustmentY)
                node.position = position
                allNodes.append(node)
                if cell == .labirint {
                    let spacing = 120
                    let player = PlayerNode()
                    player.position = CGPoint(x: position.x, y: position.y - CGFloat(spacing))
                    allNodes.append(player)
                }
            }
        }
        if mapType == .starCollecting {
            let boundryNode = getBoundary(map: map)
            allNodes.append(boundryNode)
        }
        return allNodes
    }
}
