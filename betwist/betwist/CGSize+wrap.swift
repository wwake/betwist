import Foundation

extension CGSize {
  func translateWrapped(_ translation: CGSize, _ theBoardSize: CGFloat) -> CGSize {
    var offset = self

    let visibleSize: CGFloat = theBoardSize / 2
    while offset.width < -25 {
      offset.width += visibleSize
    }
    while offset.width >= 25 {
      offset.width -= visibleSize
    }

    while offset.height < 0 {
      offset.height += visibleSize - 25
    }
    while offset.height >= visibleSize {
      offset.height -= visibleSize
    }

    return offset
  }
}
