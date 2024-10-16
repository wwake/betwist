@testable import betwist
import Foundation
import Testing

struct ACGSize {
  @Test
  func translateWrapped_translates_from_zero_by_a_small_amount() {
    let sut = CGSize(width: 100, height: 200)

    let result = sut.wrap(500)

    #expect(result.width == 100)
    #expect(result.height == 200)
  }

  @Test
  func translateWrapped_adds_wrap_to_too_negative_a_value() {
    let sut = CGSize(width: -251, height: -250)

    let result = sut.wrap(500)
    #expect(result.width == 249)
    #expect(result.height == -250)
  }

  @Test
  func translateWrapped_subtracts_wrap_from_too_big_a_value() {
    let sut = CGSize(width: 249, height: 250)

    let result = sut.wrap(500)
    #expect(result.width == 249)
    #expect(result.height == -250)
  }
}
