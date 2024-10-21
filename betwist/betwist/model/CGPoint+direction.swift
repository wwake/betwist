import SwiftUI

extension CGPoint {
  func direction(to: CGPoint) -> Directions {
    let deltaX = to.x - self.x
    let deltaY = to.y - self.y

    if abs(deltaX) >= abs(deltaY) {
      if deltaX > 0 {
        return .right
      }
      return .left
    } else {
      if deltaY > 0 {
        return .down
      }
      return .up
    }
  }
}
