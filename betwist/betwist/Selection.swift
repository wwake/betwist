struct Selection {
  let board: Board

  var selection = [Location]()

  var count: Int {
    selection.count
  }

  var last: Location? {
    selection.last
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
    if count == 0 {
      selection = [location]
    } else if selection.contains(location) {
      let index = selection.firstIndex(of: location)!
      selection = selection.dropLast(count - index - 1)
    } else if board.hasNeighbors(last!, location) {
      selection.append(location)
    } else {
      selection = [location]
    }
  }
}
