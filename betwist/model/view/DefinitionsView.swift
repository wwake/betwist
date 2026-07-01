import SwiftUI

struct DefinitionsView: View {
  @Environment(\.dismiss)
  private var dismiss

  let urlBase = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  var word: String

  @State var definitionState = DefinitionState.idle
  @State var definitions = [WordEntry]()

  fileprivate func definitionsView() -> some View {
    VStack(alignment: .leading) {
      ForEach(definitions, id: \.self) { entry in
        Text(verbatim: entry.word)
          .font(.title)

        ForEach(entry.meanings, id: \.self) { meaning in
          Text(meaning.partOfSpeech)
            .font(.title2)
            .italic()
            .padding(.bottom, 2)

          ForEach(meaning.definitions.enumerated(), id: \.0) { index, definition in
            Text("\(index + 1). \(definition.definition)")
              .padding(.bottom, 2)
          }
        }
      }
      .frame(maxWidth: .infinity, alignment: .topLeading)
    }
  }

  fileprivate func fetchData(_ url: URL) async throws -> (Data) {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
  }

  var body: some View {
    VStack {
      ScrollView {
        switch definitionState {
        case .idle:
          ProgressView()

        case .badUrl:
          ContentUnavailableView(
            "Internal Problem (Bad URL) - please contact support",
            systemImage: "exclamationmark.triangle"
          )

        case .failedLoad:
          ContentUnavailableView {
            Label(
              "Unable to Fetch Definition",
              systemImage: "exclamationmark.triangle"
            )
          } description: {
            Text("Check your internet connection or try again later.")
          }

        case .notFound:
          ContentUnavailableView {
            Label(
              "Word Not Found",
              systemImage: "exclamationmark.triangle"
            )
          } description: {
            Text("Try searching Wiktionary or on the web generally.")
          }

        case .data:
          if definitions.isEmpty {
            ContentUnavailableView(
              "No Definition Available",
              systemImage: "exclamationmark.triangle"
            )
          } else {
            definitionsView()
          }
        }
      }
      .defaultScrollAnchor(.topLeading, for: .alignment)

      Spacer()

      Button("Done") {
        dismiss()
      }
      .capsuled()
      .frame(alignment: .center)
    }
    .foregroundStyle(.black)
    .padding(12)
    .task {
      let loader = DefinitionLoader()
      definitionState = await loader.load(word, fetchData: fetchData)

      if case .data(let data) = definitionState {
        definitions = data
      } else {
        definitions = []
      }
    }
  }
}
