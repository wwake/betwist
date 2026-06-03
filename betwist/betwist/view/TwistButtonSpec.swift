import SwiftUI

struct TwistButtonSpec {
  static let quarterTurn = .pi / 2.0

  let label: Label<Text, Image>
  let animation: BoardAnimation
  let twist: Twist
  let boardTwist: CGAffineTransform
  let untwist: CGAffineTransform

  static let rotateLeft = TwistButtonSpec(
    label: Label("Rotate Left", systemImage: "arrow.counterclockwise"),
    animation: BoardAnimation(Angle.degrees(-90), Axis(x: 0, y: 0, z: 1)),
    twist: Twist(
      twist:
        CGAffineTransformMakeRotation(-Self.quarterTurn)
        .concatenating(
          CGAffineTransformMakeTranslation(0, Double(Game.defaultSize) * RotatingGridView.cellSize)
        ),

      untwist:
        CGAffineTransformMakeRotation(Self.quarterTurn)
        .concatenating(
          CGAffineTransformMakeTranslation(RotatingGridView.cellSize, 0)
        )
    ),
    boardTwist:
      CGAffineTransformMakeRotation(-Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(0, Double(Game.defaultSize) * RotatingGridView.cellSize)
      ),

    untwist:
      CGAffineTransformMakeRotation(Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(RotatingGridView.cellSize, 0)
      )
  )

  static let rotateRight = TwistButtonSpec(
    label: Label("Rotate Right", systemImage: "arrow.clockwise" ),
    animation: BoardAnimation(Angle.degrees(90), Axis(x: 0, y: 0, z: 1)),
    twist: Twist(
      twist: CGAffineTransformMakeRotation(Self.quarterTurn)
        .concatenating(
          CGAffineTransformMakeTranslation(
            Double(Game.defaultSize) * RotatingGridView.cellSize,
            0
          )
        ),

      untwist: CGAffineTransformMakeRotation(-Self.quarterTurn)
        .concatenating(CGAffineTransformMakeTranslation(0, RotatingGridView.cellSize))
    ),
    boardTwist: CGAffineTransformMakeRotation(Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(
          Double(Game.defaultSize) * RotatingGridView.cellSize,
          0
        )
      ),

    untwist: CGAffineTransformMakeRotation(-Self.quarterTurn)
      .concatenating(CGAffineTransformMakeTranslation(0, RotatingGridView.cellSize))
  )

  static let mirrorHorizontally = TwistButtonSpec(
    label: Label("Mirror Horizontally", systemImage: "arrow.left.arrow.right"),
    animation: BoardAnimation(Angle.degrees(180), Axis(x: 0, y: 1, z: 0)),
    twist: Twist(
      twist: CGAffineTransformMakeScale(-1, 1)
        .concatenating(
          CGAffineTransformMakeTranslation(
            Double(Game.defaultSize) * RotatingGridView.cellSize,
            0
          )
        ),
      untwist: CGAffineTransformMakeTranslation(-RotatingGridView.cellSize, 0)
        .concatenating(CGAffineTransformMakeScale(-1, 1))
    ),
    boardTwist: CGAffineTransformMakeScale(-1, 1)
      .concatenating(
        CGAffineTransformMakeTranslation(
          Double(Game.defaultSize) * RotatingGridView.cellSize,
          0
        )
      ),

    untwist: CGAffineTransformMakeTranslation(-RotatingGridView.cellSize, 0)
      .concatenating(CGAffineTransformMakeScale(-1, 1))
  )

  static let mirrorVertically = TwistButtonSpec(
    label: Label("Mirror Vertically", systemImage: "arrow.up.arrow.down"),
    animation: BoardAnimation(Angle.degrees(180), Axis(x: 1, y: 0, z: 0)),
    twist: Twist(
      twist: CGAffineTransformMakeScale(1, -1)
        .concatenating(
          CGAffineTransformMakeTranslation(
            0,
            Double(Game.defaultSize) * RotatingGridView.cellSize
          )
        ),

      untwist: CGAffineTransformMakeTranslation(0, -RotatingGridView.cellSize)
        .concatenating(CGAffineTransformMakeScale(1, -1))
    ),
    boardTwist: CGAffineTransformMakeScale(1, -1)
      .concatenating(
        CGAffineTransformMakeTranslation(
          0,
          Double(Game.defaultSize) * RotatingGridView.cellSize
        )
      ),

    untwist: CGAffineTransformMakeTranslation(0, -RotatingGridView.cellSize)
      .concatenating(CGAffineTransformMakeScale(1, -1))
  )
}
