//
//  ContentView.swift
//  Shared
//
//  Created by Marat Say on 7/6/20.
//

import SwiftUI
import Combine

struct DataItem: Identifiable {
    var id = UUID()
    var text: String
}

private let imageWidth: CGFloat = 80
private let iconWidth: CGFloat = 8
private let inSpacing: CGFloat = 10
private let outSpacing: CGFloat = 5

private let deps = Dependencies()

struct ContentView: View {

  @State private var data: [DataItem] = ["1123123 12 312", "2", "3333", "44444 4", "5555555555555555", "1123123 12 312", "2", "3333", "44444 4"]
    .map {
      DataItem(text: $0)
    }

  let gridItem = GridItem(.flexible(minimum: 150, maximum: 300),
                          spacing: outSpacing)

  var body: some View {

    ScrollView {

      LazyVGrid(columns: Array(repeating: gridItem, count: 2),
                spacing: outSpacing) {

        ForEach(data) { row in

          HStack(alignment: .top) { // cell

            VStack(alignment: .leading) { // leftish text block

              HStack(alignment: .firstTextBaseline) { // user label
                Image(systemName: "person")
                  .frame(width: iconWidth, height: iconWidth)
                Text(row.text)
              }
              .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

              HStack(alignment: .firstTextBaseline) { // tags label
                Image(systemName: "tag")
                  .frame(width: iconWidth, height: iconWidth)
                Text(row.text)
              }
              .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

            }
            .padding(.all, 10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: imageWidth + (inSpacing * 2), alignment: .topLeading)

            Image("sampleImage") // big image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: imageWidth, height: imageWidth)
              .cornerRadius(10)
              .clipped(antialiased: true)
              .shadow(color: Color(.black), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
              .padding([.trailing, .top, .bottom], inSpacing)

          }
          .background(Color(.darkGray))
          .cornerRadius(15)
          .clipped(antialiased: true)
//          .onTapGesture {
//            fatalError()
//          }
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, outSpacing)
    }
    .frame(width: 400, height: 400)
    .onAppear {
      deps.client.fetchImageList(for: <#T##String#>, completion: <#T##(Result<[PhotoInfo], APIError>) -> Void#>)
    }
  }
//  .navigationBarTitle("Navigation")
}

struct ContentView_Previews: PreviewProvider {

  static var previews: some View {
    ContentView()
  }
}
