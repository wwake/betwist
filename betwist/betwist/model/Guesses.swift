struct Guess: Equatable {
  let word: String
  let userGuessed: Bool

  var count: Int {
    word.count
  }
}

struct Guesses {
  var guesses = [Guess]()

  mutating func guess(_ guessString: String) {
    guess(guessString, userGuessed: true)
  }

  mutating func guessPrefix(_ guessString: String) {
    guess(guessString, userGuessed: false)
  }

  fileprivate mutating func guess(_ guessString: String, userGuessed: Bool) {
    let guess = Guess(word: guessString, userGuessed: userGuessed)
    guesses.removeAll { $0 == guess }
    guesses.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    guesses.isEmpty
  }

  var wordCount: Int {
    guesses.count
  }

  var letterCount: Int {
    guesses.reduce(0) { soFar, guess in
      soFar + guess.count
    }
  }

  var mostLetters: Int {
    guesses
      .map { $0.count }
      .max() ?? 0
  }

  var preview: String {
    String(
      guesses
      .prefix(3)
      .map { $0.word }
      .joined(by: "\n")
    )
  }
}

extension Guesses: Equatable { }

extension Guesses: CustomStringConvertible {
  public var description: String {
    String(guesses.map { $0.word }.joined(by: "\n"))
  }
}
