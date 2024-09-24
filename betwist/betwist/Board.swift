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

  func wrap(_ index: Int, _ size: Int) -> Int {
    var wrappedIndex = index
    while wrappedIndex < 0 {
      wrappedIndex += size
    }
    return wrappedIndex % size
  }

  subscript(_ row: Int, _ column: Int) -> String {
    board[wrap(row, size)][wrap(column, size)]
  }
}
