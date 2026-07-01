public struct DeltaLocation {
  let deltaRow: Int
  let deltaColumn: Int

  init(_ deltaRow: Int, _ deltaColumn: Int) {
    self.deltaRow = deltaRow
    self.deltaColumn = deltaColumn
  }
}

public struct Location: Equatable {
  public let row: Int
  public let column: Int

  public init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }

  public func hasNeighbor(_ other: Location, wrap size: Int) -> Bool {
    if self == other {
      return false
    }

    return isClose(self.row, other.row, wrap: size) && isClose(self.column, other.column, wrap: size)
  }

  fileprivate func isClose(_ index1: Int, _ index2: Int, wrap: Int) -> Bool {
    let distance = abs(index1 - index2)
    return distance <= 1 || distance == wrap - 1
  }

  public func allNeighbors(wrap size: Int) -> Set<Location> {
    let locations = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
      .map { deltaRow, deltaColumn in
        Location((row + deltaRow) %% size, (column + deltaColumn) %% size)
      }
    return Set(locations)
  }
}

extension Location: Hashable { }

extension Location: CustomDebugStringConvertible {
  public var debugDescription: String {
    "(\(row), \(column))"
  }
}
