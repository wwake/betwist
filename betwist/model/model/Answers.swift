internal import Algorithms
import Foundation

public struct Answer: Identifiable, Equatable {
  public let id = UUID()
  public let word: String

  public var count: Int {
    word.count
  }
}

public struct Answers {
  static let previewCount = 10

  internal var values = [Answer]()
  fileprivate var answersByLength = [Int: [Answer]]()

  public init(_ answers: [String] = []) {
    for answer in answers {
      submit(answer)
    }
  }

  mutating func submit(_ word: String) {
    if contains(word) {
      return
    }

    let answer = Answer(word: word)
    values.insert(answer, at: 0)
    if values.count > Self.previewCount {
      values.removeLast()
    }

    var priorAnswers = answersByLength[word.count] ?? []
    priorAnswers.append(answer)
    answersByLength.updateValue(priorAnswers, forKey: word.count)
  }

  public var isEmpty: Bool {
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

  public var preview: String {
    String(
      values
      .prefix(Self.previewCount)
      .map { $0.word }
      .joined(by: "\n")
    )
  }

  public func contains(_ word: String) -> Bool {
    let possibleAnswers = answersByLength[word.count] ?? []
    return possibleAnswers.contains { $0.word == word }
  }

  subscript (word: String) -> Answer? {
    answersByLength[word.count]?.first(where: { $0.word == word })
  }

  public var wordSizes: [Int] {
    answersByLength.keys.sorted().reversed()
  }

  public func words(ofSize: Int) -> [Answer] {
    let words = answersByLength[ofSize]
    if words == nil { return [] }

    return words!.sorted { $0.word < $1.word }
  }

  public var allWords: Set<String> {
    var results = [[String]]()
    for size in wordSizes {
      results.append(words(ofSize: size).map(\.word))
    }
    return Set(results.flatMap { $0 })
  }
}

extension Answers: Equatable { }
