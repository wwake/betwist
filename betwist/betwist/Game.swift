struct Game {
  let board: Board
  var selection: Selection

  init(_ size: Int, _ source: any Sequence<String>) {
    self.board = Board(size, source)

    self.selection = Selection(board)
  }
}
