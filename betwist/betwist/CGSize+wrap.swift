import Foundation

extension CGSize {
  func wrap(_ wrap: CGFloat) -> CGSize {
    var offset = self

    let boundary = 0.5 * wrap
    while offset.width < -boundary {
      offset.width += wrap
    }
    while offset.height < -boundary {
      offset.height += wrap
    }

    while offset.width >= boundary {
      offset.width -= wrap
    }

    while offset.height >= boundary {
      offset.height -= wrap
    }

      return offset
//
//    let visibleSize: CGFloat = wrap / 2
//    while offset.width < -25 {
//      offset.width += visibleSize
//    }
//    while offset.width >= 25 {
//      offset.width -= visibleSize
//    }
//
//    while offset.height < 0 {
//      offset.height += visibleSize - 25
//    }
//    while offset.height >= visibleSize {
//      offset.height -= visibleSize
//    }
//
//    return offset
  }
}
