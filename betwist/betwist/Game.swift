struct Game {
  let grid: Grid
  var selection: Selection
  var guesses = [String]()

  init(_ size: Int, _ source: any Sequence<String>) {
    self.grid = Grid(size, source)

    self.selection = Selection(grid)
  }

  var size: Int {
    grid.size
  }

  var guess: String {
    selection.guess
  }

  subscript(_ row: Int, _ column: Int) -> String {
    grid[row, column]
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
