@testable import betwist
import Testing

struct TheAnswers {
  @Test
  func inserts_word_at_the_beginning() {
    var sut = Answers()
    sut.submit("STICKS")
    sut.submit("FISH")
    #expect(sut.preview == "FISH\nSTICKS")
  }

  @Test
  func doesnt_allow_duplicate_words() {
    var sut = Answers()
    sut.submit("FISH")
    sut.submit("STICKS")

    sut.submit("FISH")

    #expect(sut.preview == "STICKS\nFISH")
  }

  @Test
  func knows_whether_it_contains_a_word() {
    var sut = Answers()
    sut.submit("FRIED")

    #expect(sut.contains("FRIED"))
    #expect(!sut.contains("BOILED"))
  }

  @Test
  func knows_words_grouped_by_size_and_sorted_within_group() {
    var sut = Answers()
    sut.submit("FISH")
    sut.submit("BARD")
    sut.submit("STICK")
    sut.submit("SANDWICH")

    #expect(sut.wordSizes == [8, 5, 4])
    #expect(sut.words(ofSize: 4).map { $0.word } == ["BARD", "FISH"])
  }
}
