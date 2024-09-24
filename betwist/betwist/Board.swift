struct Board {
  let size: Int
  let board: [[String]]

  init(_ size: Int) {
    self.size = size
    self.board = [
      ["A", "B", "C", "D"],
      ["E", "F", "G", "H"],
      ["A", "B", "C", "D"],
      ["E", "F", "G", "H"],
    ]
  }

  subscript(_ row: Int, _ column: Int) -> String {
    var wrappedRow = row
    while wrappedRow < 0 {
      wrappedRow += size
    }

    var wrappedColumn = column
    while wrappedColumn < 0 {
      wrappedColumn += size
    }

    return board[wrappedRow % size][wrappedColumn % size]
  }
}
