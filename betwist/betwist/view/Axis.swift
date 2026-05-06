import Foundation

typealias Axis = (x: CGFloat, y: CGFloat, z: CGFloat)

func invert(_ axis: Axis) -> Axis {
  Axis(x: -1.0 * axis.x, y: -1.0 * axis.y, z: -1.0 * axis.z)
}
