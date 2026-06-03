import Foundation

struct Twist {
  let board: CGAffineTransform
  let letter: CGAffineTransform

  func apply(_ newTwist: Twist) -> Twist {
    Twist(
      board: board.concatenating(newTwist.board),
      letter: newTwist.letter.concatenating(letter)
    )
  }
}
