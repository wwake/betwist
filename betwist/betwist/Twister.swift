enum Directions {
  case up, down, left, right
}

struct Twister {
  var size: Int

  var corner: Location

  init(_ size: Int) {
    self.size = size
    self.corner = Location(0, 0)
  }

  mutating func twist(_ direction: Directions) {
    switch direction {
    case .left:
      corner = Location(corner.row, (corner.column + 1) %% size)

    case .right:
      corner = Location(corner.row, (corner.column - 1) %% size)

    case .up:
      corner = Location((corner.row + 1) %% size, corner.column)

    case .down:
      corner = Location((corner.row - 1) %% size, corner.column)
    }
  }

  var rowIndexes: [Int] {
    (0..<size).map { (corner.row + $0) %% size }
  }

  var columnIndexes: [Int] {
    (0..<size).map { (corner.column + $0) %% size }
  }
}
