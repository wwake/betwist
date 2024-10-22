enum Directions {
  case up, down, left, right
}

struct Twister {
  var size: Int

  let deltas: [Directions: DeltaLocation] = [
    .left: DeltaLocation(0, 1),
    .right: DeltaLocation(0, -1),
    .up: DeltaLocation(1, 0),
    .down: DeltaLocation(-1, 0),
  ]

  init(_ size: Int) {
    self.size = size
  }

  var rowIndexes: [Int] {
    (0..<size).map { $0 %% size }
  }

  var columnIndexes: [Int] {
    (0..<size).map { $0 %% size }
  }
}

// 0,0  0,1  0,2   ABC
// 1,0  1,1  1,2   DEF
// 2,0  2,1  2,2   GHI

// transpose:  a[i,j] = a[j,i]
// ADG
// BEH
// CFI

// =>
// vertical flip  a[i,j] = a[n-i, j]   (n=size-1)

// 0,2  1,2  2,2   CFI
// 0,1  1,1  2,1   BEH
// 0,0  1,0  2,0   ADG

// a[i,j] = a[j, n-i]
