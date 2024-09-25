struct Location: Equatable {
  let row: Int
  let column: Int

  init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }

  func isClose(_ other: Location, wrap: Int) -> Bool {
    isClose(self.row, other.row, wrap: wrap) && isClose(self.column, other.column, wrap: wrap)
  }

  fileprivate func isClose(_ index1: Int, _ index2: Int, wrap: Int) -> Bool {
    let distance = abs(index1 - index2)
    return distance <= 1 || distance == wrap - 1
  }
}
