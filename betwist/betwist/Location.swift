struct DeltaLocation {
  let deltaRow: Int
  let deltaColumn: Int

  init(_ deltaRow: Int, _ deltaColumn: Int) {
    self.deltaRow = deltaRow
    self.deltaColumn = deltaColumn
  }
}

struct Location: Equatable {
  let row: Int
  let column: Int

  init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }

  func hasNeighbor(_ other: Location, wrap size: Int) -> Bool {
    if self == other {
      return false
    }

    return isClose(self.row, other.row, wrap: size) && isClose(self.column, other.column, wrap: size)
  }

  fileprivate func isClose(_ index1: Int, _ index2: Int, wrap: Int) -> Bool {
    let distance = abs(index1 - index2)
    return distance <= 1 || distance == wrap - 1
  }

  func allNeighbors(wrap size: Int) -> Set<Location> {
    let locations = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
      .map { deltaRow, deltaColumn in
        Location((row + deltaRow) %% size, (column + deltaColumn) %% size)
      }
    return Set(locations)
  }

  func movedBy(_ delta: DeltaLocation, wrap size: Int) -> Location {
    Location(
      (self.row + delta.deltaRow) %% size,
      (self.column + delta.deltaColumn) %% size
    )
  }
}

extension Location: Hashable { }

extension Location: CustomDebugStringConvertible {
  var debugDescription: String {
    "(\(row), \(column))"
  }
}
