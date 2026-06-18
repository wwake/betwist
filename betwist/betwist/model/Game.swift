enum GameMode {
  case play
  case review
}

public struct Game {
  static let defaultSize = 5
  static let minimumSize = 4
  static let minimumSystemAnswerSize = 6
  static let maxPuzzleSize = 25

  var mode = GameMode.play

  let grid: LetterGrid

  var selection: Selection

  var answers = Answers()

  var vocabulary: Vocabulary

  var message = ""

  private var hues: [Double]

  init(_ size: Int, _ source: any Sequence<String>, _ vocabulary: Vocabulary) {
    self.grid = LetterGrid(size, Array(source))

    self.selection = Selection(grid)
    self.vocabulary = vocabulary

    self.hues = (0..<(Self.maxPuzzleSize * Self.maxPuzzleSize)).map { _ in Double.random(in: 0..<1.0) }
  }

  var size: Int {
    grid.size
  }

  var answer: String {
    selection.answer
  }

  var hasAnswers: Bool {
    !answers.isEmpty
  }

  subscript(_ row: Int, _ column: Int) -> String {
    grid[row, column]
  }

  subscript(_ location: Location) -> String {
    grid[location.row, location.column]
  }

  mutating func select(_ location: Location) {
    selection.select(location)
    message = ""
  }

  var hasSelection: Bool {
    !selection.isEmpty
  }

  mutating func deselectAll() {
    selection.clear()
    message = ""
  }

  func type(at location: Location) -> SelectionType {
    selection.type(location)
  }

  func type(at location: Location, in selection: Selection) -> SelectionType {
    selection.type(location)
  }

  func hue(at location: Location) -> Double {
    hues[location.row * size + location.column]
  }

  mutating func validate() {
    if answer.count == 0 { return }

    if answer.count < Self.minimumSize {
      message = "Too short!"
    } else if answers.contains(answer) {
      message = "Duplicate!"
    } else if !vocabulary.contains(answer) {
      message = "Not a word!"
    } else {
      message = ""
    }
  }

  var hasValidSelection: Bool {
    message.isEmpty
  }

  fileprivate func properPrefixes(of word: String) -> [String] {
    (Self.minimumSize..<word.count)
      .map { String(word.prefix($0)) }
  }

  mutating func submit(_ word: String) {
    for prefix in properPrefixes(of: word) where vocabulary.contains(prefix) {
        answers.submit(prefix)
    }

    if vocabulary.contains(word) {
      answers.submit(word)
    }

    deselectAll()
  }

  func lastLocationSelected(was location: Location) -> Bool {
    selection.last == location
  }

  var systemAnswers: Answers {
    Solver(
      minimumAnswerSize: Self.minimumSystemAnswerSize,
      vocabulary: vocabulary,
      grid: grid
    ).answers()
  }

  var statistics: Statistics {
    Statistics(wordCount: answers.wordCount, letterCount: answers.letterCount, mostLetters: answers.mostLetters)
  }

  public mutating func over() {
    selection.clear()
    message = "Game Over"
    mode = .review
  }
}
