import SpriteKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }

    func normalized() -> CGPoint {
        let length = distance(to: .zero)
        return CGPoint(x: x / length, y: y / length)
    }

    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }

    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    static func += (left: inout CGPoint, right: CGPoint) {
        left = CGPoint(x: left.x + right.x, y: left.y + right.y)
    }

    static func + (left: CGPoint, right: CGVector) -> CGPoint {
        return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
    }
}
