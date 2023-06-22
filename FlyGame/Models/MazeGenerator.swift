//
//  MazeGenerator.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import Foundation

class MazeGenerator {
    
    private let width: Int
    private let height: Int
    private let startX: Int
    private let startY: Int
    private var visited: [[Bool]]
    private let directions = [(0, -1), (0, 1), (-1, 0), (1, 0)]
    
    var maze: [[MapCell]]


    init() {
        self.width = 30
        self.height = 30
        self.startX = 0
        self.startY = 0
        self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
        self.visited = Array(repeating: Array(repeating: false, count: width), count: height)
    }

    func generateMaze() -> [[MapCell]] {
        visitCell(x: startX, y: startY)
        carvePath(x: startX, y: startY)
        placeEndPoint()
        return expandMatrix(maze)
    }

    private func visitCell(x: Int, y: Int) {
        visited[x][y] = true
    }

    private func isVisited(x: Int, y: Int) -> Bool {
        return visited[x][y]
    }

    private func isValidCell(x: Int, y: Int) -> Bool {
        return x >= 0 && x < height && y >= 0 && y < width
    }

    private func carvePath(x: Int, y: Int) {
        let neighbors = directions.shuffled()

        for neighbor in neighbors {
            let newX = x + neighbor.0 * 2
            let newY = y + neighbor.1 * 2

            if isValidCell(x: newX, y: newY) && !isVisited(x: newX, y: newY) {
                maze[x + neighbor.0][y + neighbor.1] = .road
                maze[newX][newY] = .road
                visitCell(x: newX, y: newY)
                carvePath(x: newX, y: newY)
            }
        }
    }

    private func placeEndPoint() {
        var maxDistance = 0
        var farthestCell: (Int, Int) = (0, 0)

        for x in 0..<height {
            for y in 0..<width {
                if maze[x][y] == .road && distance(from: (x, y), to: (startX, startY)) > maxDistance {
                    maxDistance = distance(from: (x, y), to: (startX, startY))
                    farthestCell = (x, y)
                }
            }
        }

        maze[farthestCell.0][farthestCell.1] = .end
        maze[startX][startY] = .start
    }

    private func distance(from: (Int, Int), to: (Int, Int)) -> Int {
        return abs(from.0 - to.0) + abs(from.1 - to.1)
    }
    
    private func expandMatrix(_ matrix: [[MapCell]]) -> [[MapCell]] {
        let rows = matrix.count
        let cols = matrix[0].count

        let newRows = rows + 2
        let newCols = cols + 2
        var newMatrix = [[MapCell]](repeating: [MapCell](repeating: .wall, count: newCols), count: newRows)

        for i in 0..<rows {
            for j in 0..<cols {
                let value = matrix[i][j]
                let newI = i + 1
                let newJ = j + 1
                newMatrix[newI][newJ] = value
            }
        }

        return newMatrix
    }
}
