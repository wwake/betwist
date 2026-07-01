import Foundation

public struct DefinitionLoader {
  let urlBase = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  public func load(_ word: String, fetchData: (URL) async throws -> (Data)) async -> [WordEntry] {
    if let url = URL(string: urlBase + word) {
      do {
        let data = try await fetchData(url)
        let decoder = JSONDecoder()

        if let decodedResponse = try? decoder.decode(
          [WordEntry].self,
          from: data
        ) {
          return decodedResponse
        }
        return []
      } catch {
        return []  // can't load
      }
    } else {
      return []  // bad url
    }
  }
}
