import Foundation
import Testing

@testable import model

private enum MyError: Error {
  case someError
}

struct ADefinitionLoader {
  let sut = DefinitionLoader()

  @Test
  func `bad url returns .badUrl`() async throws {
    let result = await sut.load(
      "{BAD\\||URL}",
      fetchData: { _ in Data() }
    )

    #expect(result == .badUrl)
  }

  @Test
  func `failed fetch returns .failedLoad`() async throws {
    let result = await sut.load(
      "WORD",
      fetchData: { _ in
        throw MyError.someError
      }
    )

    #expect(result == .failedLoad)
  }

  @Test
  func `failed JSON decoding returns .notFound`() async {
    let result = await sut.load(
      "WORD",
      fetchData: { _ in
        Data("{}".utf8)
      }
    )

    #expect(result == .notFound)
  }

  @Test
  func `successful load returns array`() async {
    let result = await sut.load(
      "WORD",
      fetchData: { _ in
        Data(
"""
[{"word": "call", "meanings": []}]
"""
.utf8
        )
      }
    )

    if case let .data(data) = result {
      #expect(data.count == 1)
    } else {
      Issue.record("Wrong result type")
    }
  }
}
