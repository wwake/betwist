import Foundation

public enum DefinitionState: Equatable {
  case idle
  case data([WordEntry])
  case failedLoad
}

public struct DefinitionLoader {
  let urlBase = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  public func load(_ word: String, fetchData: (URL) async throws -> (Data))
    async -> DefinitionState
  {

    guard let url = URL(string: urlBase + word) else {
      return .data([])  // bad url
    }

    let data: Data
    do {
      data = try await fetchData(url)
    } catch {
      return .failedLoad
    }

    let decoder = JSONDecoder()

    if let decodedResponse = try? decoder.decode(
      [WordEntry].self,
      from: data
    ) {
      return .data(decodedResponse)
    }
    return .data([])
  }
}
