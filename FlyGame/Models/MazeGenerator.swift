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
        self.width = 40
        self.height = 40
        self.startX = 0
        self.startY = 0
        self.maze = Array(repeating: Array(repeating: .wall, count: width), count: height)
        self.visited = Array(repeating: Array(repeating: false, count: width), count: height)
        
        generateMaze()
    }

    func generateMaze() {
        visitCell(x: startX, y: startY)
        carvePath(x: startX, y: startY)
        placeEndPoint()
        expandMatrix(maze)
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
    
    private func expandMatrix(_ matrix: [[MapCell]]) {
        let rows = matrix.count
        let cols = matrix[0].count

        let newRows = rows + 1
        let newCols = cols + 1
        var newMatrix = [[MapCell]](repeating: [MapCell](repeating: .wall, count: newCols), count: newRows)

        for i in 0..<rows {
            for j in 0..<cols {
                let value = matrix[i][j]
                let newI = i + 1
                let newJ = j + 1
                newMatrix[newI][newJ] = value
            }
        }

        maze = newMatrix
    }
    
    func findPathFromStartToFinish() -> [(Int, Int)]? {
        var queue: [(Int, Int)] = []
        var visited = Array(repeating: Array(repeating: false, count: width + 1), count: height + 1)
        var parent: [[(Int, Int)?]] = Array(repeating: Array(repeating: nil, count: width + 1), count: height + 1)
        
        queue.append((startX + 1, startY + 1))
        visited[startX + 1][startY + 1] = true
        
        while !queue.isEmpty {
            let current = queue.removeFirst()
            
            if maze[current.0][current.1] == .end {
                return buildPath(parent, current)
            }
            
            let neighbors = getNeighbors(current)
            
            for neighbor in neighbors {
                if !visited[neighbor.0][neighbor.1] {
                    visited[neighbor.0][neighbor.1] = true
                    parent[neighbor.0][neighbor.1] = current
                    queue.append(neighbor)
                }
            }
        }
        
        return nil
    }
    
    private func getNeighbors(_ cell: (Int, Int)) -> [(Int, Int)] {
        let directions = [(0, -1), (0, 1), (-1, 0), (1, 0)]
        var neighbors: [(Int, Int)] = []
        
        for direction in directions {
            let newX = cell.0 + direction.0
            let newY = cell.1 + direction.1
            
            if isValidCell(x: newX, y: newY) && maze[newX][newY] != .wall {
                neighbors.append((newX, newY))
            }
        }
        
        return neighbors
    }
    
    private func buildPath(_ parent: [[(Int, Int)?]], _ current: (Int, Int)) -> [(Int, Int)] {
        var path: [(Int, Int)] = []
        var currentCell: (Int, Int)? = current
        
        while let cell = currentCell {
            path.append(cell)
            currentCell = parent[cell.0][cell.1]
        }
        
        path.reverse()
        return path
    }
}
