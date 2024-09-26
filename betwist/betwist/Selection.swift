enum SelectionType {
  case first, middle, last, open
}

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
    if let index = selection.firstIndex(of: location) {
      selection = selection.dropLast(count - index - 1)
      return
    }

    if count == 0 || board.hasNeighbors(last!, location) {
      selection.append(location)
    } else {
      selection = [location]
    }
  }

  mutating func clear() {
    selection.removeAll()
  }

  func type(_ location: Location) -> SelectionType {
    if location == last {
      return .last
    } else if selection.first == location {
      return .first
    } else if selection.contains(location) {
      return .middle
    }
    return .open
  }
}
