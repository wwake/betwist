struct Game {
  static let minimumSize = 4

  var grid: Grid
  var twister: Twister

  var selection: Selection
  var guesses = [String]()

  var message = ""

  init(_ size: Int, _ source: any Sequence<String>) {
    self.grid = Grid(size, source)
    self.twister = Twister(size)

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

  mutating func blockSelection() {
    selection.blocked = true
  }

  mutating func select(_ location: Location) {
    selection.select(location)
    message = ""
  }

  mutating func deselectAll() {
    selection.clear()
    message = ""
  }

  func type(at location: Location) -> SelectionType {
    selection.type(location)
  }

  mutating func collect() {
    guard guess.count >= Self.minimumSize else {
      message = "Word is too short"
      return
    }

    guesses.insert(guess, at: 0)
  }

  mutating func twist(_ direction: Directions) {
    twister.twist(direction)
  }

  var rowIndexes: [Int] {
    twister.rowIndexes
  }

  var columnIndexes: [Int] {
    twister.columnIndexes
  }
}
