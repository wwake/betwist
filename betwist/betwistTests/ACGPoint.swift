@testable import betwist
import SwiftUI
import Testing

struct ACGPoint {
  @Test
  func knows_left_from_right() {
    let starting = CGPoint(x: 10, y: 100)
    let ending = CGPoint(x: 100, y: 95)
    #expect(starting.direction(to: ending) == .right)
    #expect(ending.direction(to: starting) == .left)
  }

  @Test
  func knows_up_from_down() {
    let starting = CGPoint(x: 100, y: 10)
    let ending = CGPoint(x: 90, y: 95)
    #expect(starting.direction(to: ending) == .down)
    #expect(ending.direction(to: starting) == .up)
  }
}
