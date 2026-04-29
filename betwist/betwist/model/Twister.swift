struct Twister {
  var size: Int

  private var map: [[Location]]

  init(_ size: Int) {
    self.size = size

    var newTransform = Self.makeTransform(size: size)
    for row in 0..<size {
      for column in 0..<size {
        newTransform[row][column ] = Location(row, column)
      }
    }
    map = newTransform
  }

  subscript (location: Location) -> Location {
    map[location.row][location.column]
  }

  static func makeTransform(size: Int) -> [[Location]] {
    let newRow = [Location](repeating: Location(0, 0), count: size)
    return [[Location]](repeating: newRow, count: size)
  }

  static func rotateLeft(row: Int, column: Int, size: Int) -> Location {
    Location(column, size - 1 - row)
  }

  mutating func transform(_ locationTransform: (Int, Int, Int) -> Location) {
    var newTransform = map
    for row in 0..<size {
      for column in 0..<size {
        let location = Location(row, column)
        newTransform[row][column] = self[locationTransform(location.row, location.column, size)]
      }
    }
    map = newTransform
  }

  mutating func rotateRight() {
    transform(Self.rotateLeft)
    transform(Self.rotateLeft)
    transform(Self.rotateLeft)
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
