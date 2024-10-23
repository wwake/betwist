import Foundation

struct Answer: Identifiable, Equatable {
  let id = UUID()
  let word: String
  let userGuessed: Bool

  var count: Int {
    word.count
  }
}

struct Answers {
  var answers = [Answer]()

  mutating func guess(_ guessString: String) {
    guess(guessString, userGuessed: true)
  }

  mutating func guessPrefix(_ guessString: String) {
    guess(guessString, userGuessed: false)
  }

  fileprivate mutating func guess(_ guessString: String, userGuessed: Bool) {
    let guess = Answer(word: guessString, userGuessed: userGuessed)
    answers.removeAll { $0.word == guess.word }
    answers.insert(guess, at: 0)
  }

  var isEmpty: Bool {
    answers.isEmpty
  }

  var wordCount: Int {
    answers.count
  }

  var letterCount: Int {
    answers.reduce(0) { soFar, guess in
      soFar + guess.count
    }
  }

  var mostLetters: Int {
    answers
      .map { $0.count }
      .max() ?? 0
  }

  var preview: String {
    String(
      answers
      .prefix(3)
      .map { $0.word }
      .joined(by: "\n")
    )
  }
}

extension Answers: Equatable { }
