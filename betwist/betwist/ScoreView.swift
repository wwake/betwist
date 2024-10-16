import SwiftUI

struct ScoreView: View {
  @Binding var game: Game


  var body: some View {
    VStack(alignment: .leading) {
        Text("Score")
          .font(.title3)

      Text("Words: 7")
        .bold()

      Text("Letters: 67")

      Text("Most Letters: 7")
    }
    .bold()
  }
}


//#Preview {
//    ScoreView()
//}
