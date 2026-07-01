import CoreGraphics
import Foundation

struct Twist {
  let board: CGAffineTransform
  let letter: CGAffineTransform

  init(
     board: CGAffineTransform = CGAffineTransformIdentity,
     letter: CGAffineTransform = CGAffineTransformIdentity
  ) {
    self.board = board
    self.letter = letter
  }

  func apply(_ newTwist: Twist) -> Twist {
    Twist(
      board: board.concatenating(newTwist.board),
      letter: newTwist.letter.concatenating(letter)
    )
  }
}
