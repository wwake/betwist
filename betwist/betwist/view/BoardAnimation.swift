import SwiftUI

struct BoardAnimation {
  let angle: Angle
  let axis: Axis

  static let zero = BoardAnimation(Angle.zero, Axis(x: 0.0, y: 0.0, z: 0.0))

  init(_ angle: SwiftUICore.Angle, _ axis: Axis) {
    self.angle = angle
    self.axis = axis
  }

  var axisInverted: Axis {
    invert(axis)
  }
}
