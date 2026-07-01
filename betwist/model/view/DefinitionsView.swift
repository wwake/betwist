import SwiftUI

struct DefinitionsView: View {
  @Environment(\.dismiss)
  private var dismiss

  let urlBase = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  var word: String

  @State var definitions: [WordEntry]

  var body: some View {
    VStack {
      ScrollView {
        if definitions.isEmpty {
          ContentUnavailableView(
            "No Definition Available",
            systemImage: "exclamationmark.triangle"
          )
        } else {
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
            .frame(alignment: .topLeading)
          }
        }
      }

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
      if let url = URL(string: urlBase + word) {
        do {
          let (data, _) = try await URLSession.shared.data(from: url)
          let decoder = JSONDecoder()

          if let decodedResponse = try? decoder.decode(
            [WordEntry].self,
            from: data
          ) {
            definitions = decodedResponse
          }
        } catch {
          definitions = []  // can't load
        }
      } else {
        definitions = []  // bad url
      }
    }
  }
}
