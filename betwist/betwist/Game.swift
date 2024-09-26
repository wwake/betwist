struct Game {
  let board: Board
  var selection: Selection

  init(_ size: Int, _ source: any Sequence<String>) {
    self.board = Board(size, source)

    self.selection = Selection(board)
  }

  var size: Int {
    board.size
  }

  var guess: String {
    selection.guess
  }

  mutating func deselectAll() {
    selection.clear()
  }

  subscript(_ row: Int, _ column: Int) -> String {
    board[row, column]
  }

  mutating func select(_ location: Location) {
    selection.select(location)
  }
}
