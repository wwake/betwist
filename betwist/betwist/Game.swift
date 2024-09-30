struct Game {
  let board: Board
  var selection: Selection
  var guesses = [String]()

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

  subscript(_ row: Int, _ column: Int) -> String {
    board[row, column]
  }

  mutating func deselectAll() {
    selection.clear()
  }

  mutating func select(_ location: Location) {
    selection.select(location)
  }

  func type(at location: Location) -> SelectionType {
    selection.type(location)
  }

  mutating func collect() {
    guesses.insert(guess, at: 0)
  }
}
