struct Guesses {
  var guesses = [String]()

  mutating func prepend(_ guess: String) {
    guesses.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    guesses.isEmpty
  }

  var asString: String {
    String(guesses.joined(by: "\n"))
  }
}
