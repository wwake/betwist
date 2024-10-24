import Foundation

struct Answer: Identifiable, Equatable {
  let id = UUID()
  let word: String
  let enteredByUser: Bool

  var count: Int {
    word.count
  }
}

struct Answers {
  static let previewCount = 3

  internal var values = [Answer]()
  fileprivate var answersByLength = [Int: [Answer]]()

  mutating func submit(_ word: String, isPrefix: Bool) {
    if contains(word) {
      return
    }

    let answer = Answer(word: word, enteredByUser: !isPrefix)
    values.insert(answer, at: 0)
    if values.count > Self.previewCount {
      values.removeLast()
    }

    var priorAnswers = answersByLength[word.count] ?? []
    priorAnswers.append(answer)
    answersByLength.updateValue(priorAnswers, forKey: word.count)
  }

  var isEmpty: Bool {
    answersByLength.isEmpty
  }

  var wordCount: Int {
    answersByLength.reduce(0) { soFar, answers in
      soFar + answers.value.count
    }
  }

  var letterCount: Int {
    answersByLength.reduce(0) { soFar, answers in
      soFar + answers.key * answers.value.count
    }
  }

  var mostLetters: Int {
    answersByLength.keys.max() ?? 0
  }

  var preview: String {
    String(
      values
      .prefix(Self.previewCount)
      .map { $0.word }
      .joined(by: "\n")
    )
  }

  func contains(_ word: String) -> Bool {
    let possibleAnswers = answersByLength[word.count] ?? []
    return possibleAnswers.contains { $0.word == word }
  }

  subscript (word: String) -> Answer? {
    answersByLength[word.count]?.first(where: { $0.word == word })
  }

  var wordSizes: [Int] {
    answersByLength.keys.sorted().reversed()
  }

  func words(ofSize: Int) -> [Answer] {
    let words = answersByLength[ofSize]
    if words == nil { return [] }

    return words!.sorted { $0.word < $1.word }
  }
}

extension Answers: Equatable { }
