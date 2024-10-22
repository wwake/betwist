struct Game {
  static let minimumSize = 4
  static let maxPuzzleSize = 10

  var grid: LetterGrid
  var twister: Twister

  var selection: Selection
  var guesses = Guesses()

  var vocabulary: Vocabulary

  var message = ""

  private var hues: [Double]

  init(_ size: Int, _ source: any Sequence<String>, _ vocabulary: Vocabulary = NullVocabulary()) {
    self.grid = LetterGrid(size, source)
    self.twister = Twister(size)

    self.selection = Selection(grid)
    self.vocabulary = vocabulary

    self.hues = (0..<(Self.maxPuzzleSize * Self.maxPuzzleSize)).map { _ in Double.random(in: 0..<1.0) }
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

  subscript(_ location: Location) -> String {
    grid[location.row, location.column]
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
    type(at: location, in: selection)
  }

  func type(at location: Location, in selection: Selection) -> SelectionType {
    selection.type(location)
  }

  func hue(at location: Location) -> Double {
    hues[location.row * size + location.column]
  }

  mutating func validate() {
    if guess.count == 0 { return }

    if guess.count < Self.minimumSize {
      message = "Word is too short"
    } else if !vocabulary.contains(guess) {
      message = "That's not a word!"
    }
  }

  mutating func collect() {
    guard message.isEmpty && !guess.isEmpty else { return }

    for length in Self.minimumSize...guess.count {
      let prefix = String(guess.prefix(length))
      if vocabulary.contains(prefix) {
        guesses.prepend(prefix)
      }
    }
  }

  func lastLocationSelected(was location: Location) -> Bool {
    selection.last == location
  }

  var rowIndexes: [Int] {
    twister.rowIndexes
  }

  var columnIndexes: [Int] {
    twister.columnIndexes
  }

  var allAnswers: Set<String> {
    var result = Set<String>()
    let selection = Selection(grid)
    tryAllExtensions(&result, selection, openNeighbors(selection))
    return result
  }

  func openNeighbors(_ selection: Selection) -> Set<Location> {
    guard selection.last != nil else {
      return allLocations
    }

    let locations = selection.last!.allNeighbors(wrap: size)

    return Set(locations)
      .filter {
        type(at: $0, in: selection) == .open
        || type(at: $0, in: selection) == .neighbor
      }
  }

  fileprivate var allLocations: Set<Location> {
    var neighbors = Set<Location>()
    for row in rowIndexes {
      for column in columnIndexes {
        neighbors.insert(Location(row, column))
      }
    }
    return neighbors
  }

  fileprivate func tryAllExtensions(_ result: inout Set<String>, _ selection: Selection, _ neighbors: Set<Location>) {
    for location in neighbors {
      let newSelection = Selection(selection, location)
      let (contained, prefixed) = vocabulary.containsAndPrefixes(newSelection.guess)
      if contained {
        result.insert(newSelection.guess)
      }
      if prefixed {
        let neighbors = openNeighbors(newSelection)
        tryAllExtensions(&result, newSelection, neighbors)
      }
    }
  }

  var score: Score {
    Score(wordCount: guesses.wordCount, letterCount: guesses.letterCount, mostLetters: guesses.mostLetters)
  }
}
