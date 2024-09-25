struct Selection {
  let board: Board

  var selection = [Location]()

  var count: Int {
    selection.count
  }

  var guess: String {
    selection
      .map { location in
        board[location.row, location.column]
      }
      .joined()
  }

  init(_ board: Board) {
    self.board = board
  }

  mutating func select(_ location: Location) {
    selection.append(location)
  }
}
