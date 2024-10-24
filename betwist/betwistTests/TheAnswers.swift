@testable import betwist
import Testing

struct TheAnswers {
  @Test
  func inserts_word_at_the_beginning() {
    var sut = Answers()
    sut.submit("STICKS", isPrefix: true)
    sut.submit("FISH", isPrefix: true)
    #expect(sut.preview == "FISH\nSTICKS")
  }

  @Test
  func knows_whether_word_was_submitted_as_a_prefix() {
    var sut = Answers()
    sut.submit("FISH", isPrefix: true)
    sut.submit("SPLASH", isPrefix: false)
    #expect(sut.values[0].word == "SPLASH")
    #expect(sut.values[0].enteredByUser == true)
    #expect(sut.values[1].word == "FISH")
    #expect(sut.values[1].enteredByUser == false)
  }

  @Test
  func doesnt_allow_duplicate_words() {
    var sut = Answers()
    sut.submit("FISH", isPrefix: true)
    sut.submit("STICKS", isPrefix: true)

    sut.submit("FISH", isPrefix: false)

    #expect(sut.preview == "STICKS\nFISH")
  }

  @Test
  func knows_whether_it_contains_a_word() {
    var sut = Answers()
    sut.submit("FRIED", isPrefix: false)

    #expect(sut.contains("FRIED"))
    #expect(!sut.contains("BOILED"))
  }

  @Test
  func knows_words_grouped_by_size_and_sorted_within_group() {
    var sut = Answers()
    sut.submit("FISH", isPrefix: true)
    sut.submit("BARD", isPrefix: true)
    sut.submit("STICK", isPrefix: true)
    sut.submit("SANDWICH", isPrefix: true)

    #expect(sut.wordSizes == [8, 5, 4])
    #expect(sut.words(ofSize: 4).map { $0.word } == ["BARD", "FISH"])
  }
}
