//
//  MapFactory.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import SpriteKit

enum MapType {
    case labirinth, starCollecting
}

class MapFactory {
    
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
            return EnemyNode()
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
    
    private func setEnemy(row: Int, col: Int, rightPath: [(Int, Int)]) -> Bool {
        guard !rightPath.contains(where: { $0 == (row, col) }) else { return false }
        let random = Int.random(in: 0...5)
        guard random == 0 else { return false }
        return true
    }
    
    func setupMap(map: [[MapCell]], mapType: MapType, rightPath: [(Int, Int)]? = nil) -> [SKNode] {
        var allNodes = [SKNode]()
        let spacing = mapType == .labirinth ? labirintSpacing : spacing
        for (row, val) in map.enumerated() {
            for (col, cell) in val.enumerated() {
                guard let node = createNode(cell: cell) else { continue }
                
                let adjustmentX = mapType == .labirinth ? 0 : Int.random(in: -100...100)
                let adjustmentY = mapType == .labirinth ? 0 : Int.random(in: -100...100)
                
                let position = CGPoint(x: (spacing * col) + adjustmentX, y: (spacing * row) + adjustmentY)
                node.position = position
                if node is EnemyNode {
                    guard let rightPath = rightPath, setEnemy(row: row, col: col, rightPath: rightPath) else { continue }
                    allNodes.append(node)
                }
                else {
                    allNodes.append(node)
                }
                
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
