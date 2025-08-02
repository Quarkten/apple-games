import SpriteKit

extension SKAction {
    class func shake(duration: TimeInterval, amplitudeX: Int, amplitudeY: Int) -> SKAction {
        let numberOfShakes = Int(duration * 60)
        var actions: [SKAction] = []
        for _ in 0..<numberOfShakes {
            let dx = CGFloat(arc4random_uniform(UInt32(amplitudeX * 2))) - CGFloat(amplitudeX)
            let dy = CGFloat(arc4random_uniform(UInt32(amplitudeY * 2))) - CGFloat(amplitudeY)
            let moveBy = SKAction.moveBy(x: dx, y: dy, duration: 0.01)
            actions.append(moveBy)
            actions.append(moveBy.reversed())
        }
        return SKAction.sequence(actions)
    }
}
