enum SelectionType {
  case first, middle, last, open, neighbor
}

struct Selection {
  let grid: LetterGrid

  var selection = [Location]()

  var blocked = false

  init(grid: LetterGrid) {
    self.grid = grid
  }

  init(_ from: Selection, _ location: Location) {
    self.grid = from.grid
    selection = from.selection
    selection.append(location)
  }

  var count: Int {
    selection.count
  }

  var last: Location? {
    selection.last
  }

  var answer: String {
    selection
      .map { location in
        grid[location.row, location.column]
      }
      .joined()
  }

  init(_ board: LetterGrid) {
    self.grid = board
  }

  mutating func select(_ location: Location) {
    guard !blocked else { return }

    if let index = selection.firstIndex(of: location) {
      selection = selection.dropLast(count - index - 1)
      return
    }

    if count == 0 || grid.hasNeighbors(last!, location) {
      selection.append(location)
    } else {
      selection = [location]
    }
  }

  mutating func clear() {
    selection.removeAll()
    blocked = false
  }

  func type(_ location: Location) -> SelectionType {
    if location == last {
      return .last
    } else if selection.first == location {
      return .first
    } else if selection.contains(location) {
      return .middle
    } else if last == nil {
      return .open
    } else if last!.hasNeighbor(location, wrap: grid.size) {
      return .neighbor
    }
    return .open
  }
}
