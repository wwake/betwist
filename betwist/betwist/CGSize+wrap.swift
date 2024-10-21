import Foundation

extension CGSize {
  func wrap(_ wrap: Double) -> CGSize {
    var offset = self

    offset.width = offset.width.wrap0Centered(wrap)
    offset.height = offset.height.wrap0Centered(wrap)

    return offset
  }
}

extension CGFloat {
  func wrap0Centered(_ wrap: Double) -> Double {
    var value = self
    let boundary = 0.5 * wrap

    while value < -boundary {
      value += wrap
    }

    while value >= boundary {
      value -= wrap
    }

    return value
  }
}
