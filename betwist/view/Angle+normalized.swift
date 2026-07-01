import SwiftUI

extension Angle {
  public var normalized: Angle {
    var newAngle = self

    while newAngle >= Angle(degrees: 360) {
      newAngle -= Angle(degrees: 360)
    }
    while newAngle < Angle.zero {
      newAngle += Angle(degrees: 360)
    }

    return newAngle
  }
}
