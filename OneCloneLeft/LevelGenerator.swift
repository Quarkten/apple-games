import Foundation

enum TileType {
    case wall
    case floor
    case door
}

enum RoomType {
    case standard
    case treasure
    case boss
}

class LevelGenerator {
    private var tiles: [[TileType]] = []
    private let width: Int
    private let height: Int

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.tiles = Array(repeating: Array(repeating: .wall, count: height), count: width)
    }

    func generateLevel() {
        let room1Center = CGPoint(x: 10, y: 9)
        let room2Center = CGPoint(x: 24, y: 21)
        let room3Center = CGPoint(x: 41, y: 13)

        createRoom(x: 5, y: 5, width: 10, height: 8, type: .standard)
        createRoom(x: 20, y: 15, width: 8, height: 12, type: .treasure)
        createRoom(x: 35, y: 10, width: 12, height: 6, type: .boss)

        createCorridor(from: room1Center, to: room2Center)
        createCorridor(from: room2Center, to: room3Center)
    }

    private func createCorridor(from: CGPoint, to: CGPoint) {
        var currentX = Int(from.x)
        var currentY = Int(from.y)

        while currentX != Int(to.x) || currentY != Int(to.y) {
            if currentX != Int(to.x) && Int.random(in: 0...1) == 0 {
                let direction = Int(to.x) > currentX ? 1 : -1
                currentX += direction
            } else if currentY != Int(to.y) {
                let direction = Int(to.y) > currentY ? 1 : -1
                currentY += direction
            }

            if currentX >= 0 && currentX < self.width && currentY >= 0 && currentY < self.height {
                tiles[currentX][currentY] = .floor
            }
        }
    }

    private func createRoom(x: Int, y: Int, width: Int, height: Int, type: RoomType) {
        let roomShape = Int.random(in: 0...1) // 0 for rectangle, 1 for circle
        if roomShape == 0 {
            // Rectangle
            for i in x..<(x + width) {
                for j in y..<(y + height) {
                    if i >= 0 && i < self.width && j >= 0 && j < self.height {
                        if i == x || i == x + width - 1 || j == y || j == y + height - 1 {
                            tiles[i][j] = .wall
                        } else {
                            tiles[i][j] = .floor
                        }
                    }
                }
            }
        } else {
            // Circle
            let centerX = x + width / 2
            let centerY = y + height / 2
            let radius = min(width, height) / 2
            for i in x..<(x + width) {
                for j in y..<(y + height) {
                    let dx = i - centerX
                    let dy = j - centerY
                    if dx * dx + dy * dy <= radius * radius {
                        if i >= 0 && i < self.width && j >= 0 && j < self.height {
                            tiles[i][j] = .floor
                        }
                    }
                }
            }
        }

        if type == .treasure {
            // Add a treasure chest in the center of the room
        } else if type == .boss {
            // Add a boss in the center of the room
        }

        // Add some obstacles
        for _ in 0..<5 {
            let obstacleX = Int.random(in: x+1..<x+width-1)
            let obstacleY = Int.random(in: y+1..<y+height-1)
            if obstacleX >= 0 && obstacleX < self.width && obstacleY >= 0 && obstacleY < self.height {
                tiles[obstacleX][obstacleY] = .wall
            }
        }
    }

    func getTiles() -> [[TileType]] {
        return tiles
    }
}
