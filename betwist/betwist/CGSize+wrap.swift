import Foundation

extension CGSize {
  fileprivate func wrapDouble(_ input: Double, wrap: Double) -> Double {
    var value = input
    let boundary = 0.5 * wrap

    while value < -boundary {
      value += wrap
    }

    while value >= boundary {
      value -= wrap
    }

    return value
  }

  func wrap(_ wrap: Double) -> CGSize {
    var offset = self

    offset.width = wrapDouble(offset.width, wrap: wrap)
    offset.height = wrapDouble(offset.height, wrap: wrap)

    return offset
  }
}
