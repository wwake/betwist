import Foundation

extension CGSize {
  func wrap(_ wrap: Double) -> CGSize {
    var offset = self

    let boundary = 0.5 * wrap
    while offset.width < -boundary {
      offset.width += wrap
    }

    while offset.width >= boundary {
      offset.width -= wrap
    }

    while offset.height < -boundary {
      offset.height += wrap
    }

    while offset.height >= boundary {
      offset.height -= wrap
    }

    return offset
  }
}
