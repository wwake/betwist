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
    board[row %% size][column %% size]
  }
}
