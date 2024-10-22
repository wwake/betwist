enum Directions {
  case up, down, left, right
}

struct Twister {
  var size: Int

  var corner: Location

  let deltas: [Directions: DeltaLocation] = [
    .left: DeltaLocation(0, 1),
    .right: DeltaLocation(0, -1),
    .up: DeltaLocation(1, 0),
    .down: DeltaLocation(-1, 0),
  ]

  init(_ size: Int) {
    self.size = size
    self.corner = Location(0, 0)
  }

  mutating func twist(_ direction: Directions) {
    corner = corner.movedBy(deltas[direction]!, wrap: size)
  }

  var rowIndexes: [Int] {
    (0..<size).map { (corner.row + $0) %% size }
  }

  var columnIndexes: [Int] {
    (0..<size).map { (corner.column + $0) %% size }
  }
}

// 0,0  0,1  0,2   ABC
// 1,0  1,1  1,2   DEF
// 2,0  2,1  2,2   GHI

//=>

// 0,2  1,2  2,2   CFI
// 0,1  1,1  2,1   BEH
// 0,0  1,0  2,0   ADG
