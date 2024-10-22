struct Twister {
  var size: Int

  var transform: [[Location]]

  init(_ size: Int) {
    self.size = size

    var newTransform = Self.makeTransform(size: size)
    for row in 0..<size {
      for column in 0..<size {
        newTransform[row][column ] = Location(row, column)
      }
    }
    transform = newTransform
  }

  subscript (location: Location) -> Location {
    transform[location.row][location.column]
  }

  static func makeTransform(size: Int) -> [[Location]] {
    let newRow = [Location](repeating: Location(0, 0), count: size)
    return [[Location]](repeating: newRow, count: size)
  }

  mutating func rotateLeft() {
    var newTransform = Self.makeTransform(size: size)
    for row in 0..<size {
      for column in 0..<size {
        newTransform[row][column] = transform[column][size - 1 - row]
      }
    }
    transform = newTransform
  }

  mutating func rotateRight() {
    rotateLeft()
    rotateLeft()
    rotateLeft()
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
