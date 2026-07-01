import SwiftUI

struct DefinitionsView: View {
  let urlBase = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  var word: String

  @State var definitions: [WordEntry]

  var body: some View {
    VStack {
      if definitions.isEmpty {
        ContentUnavailableView(
          "No Definition Available",
          systemImage: "exclamationmark.triangle"
        )
      } else {
        ForEach(definitions, id: \.self) { entry in
          Text(verbatim: entry.word)
            .font(.title)

//          ForEach(entry.meanings, id: \.self) { meaning in
//                    Text(meaning.partOfSpeech)
//                      .font(.title2)
          //
          //          ForEach(meaning.definitions.enumerated(), id: \.self) {
          //            Text(
          //          }
         // }
        }
      }
    }
    .task {
      if let url = URL(string: urlBase + word) {
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          let decoder = JSONDecoder()

          if let decodedResponse = try? decoder.decode([WordEntry].self, from: data) {
            definitions = decodedResponse
          }
//          let contents = try String(contentsOf: url, encoding: .utf8)
//          print(contents)
//          definitions = Words(entries: [WordEntry(word: word, meanings: [])])
        } catch {
          definitions = []  // can't load
        }
      } else {
        definitions = [] // bad url
      }
    }
  }
}
