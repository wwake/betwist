import Foundation

struct Twist {
  let twist: CGAffineTransform
  let untwist: CGAffineTransform

  func apply(_ newTwist: Twist) -> Twist {
    Twist(
      twist: twist.concatenating(newTwist.twist),
      untwist: newTwist.untwist.concatenating(untwist)
    )
  }
}
