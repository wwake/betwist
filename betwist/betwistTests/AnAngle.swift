import SwiftUI
import Testing

@testable import betwist

struct AnAngle {
  @Test
  func normalized() {
    #expect(Angle(degrees: 210).normalized == Angle(degrees: 210))
    #expect(Angle.zero.normalized == Angle.zero)
    #expect(Angle(degrees: 360).normalized == Angle.zero)
    #expect(Angle(degrees: 720).normalized == Angle.zero)
    #expect(Angle(degrees: -180).normalized == Angle.degrees(180))
  }
}
