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
  var info: PhotoInfo
}

private let imageWidth: CGFloat = 80
private let iconWidth: CGFloat = 10
private let inSpacing: CGFloat = 10
private let outSpacing: CGFloat = 5

private let deps = Dependencies()

struct ContentView: View {

  @State private var data: [DataItem] = []
  @State private var isLoading: Bool = true

  let gridItem = GridItem(.adaptive(minimum: itemMinWidth,
                                    maximum: itemMinWidth * 2),
                          spacing: outSpacing)

  var body: some View {

    ZStack {

      ProgressView()
        .opacity(isLoading ? 1 : 0)

      ScrollView {

        LazyVGrid(columns: [gridItem],
                  spacing: outSpacing) {

          ForEach(data) { row in

            HStack(alignment: .top) { // cell

              // left-ish text block
              VStack(alignment: .leading, spacing: outSpacing) {

                HStack(alignment: .firstTextBaseline) { // user label
                  Image(systemName: "person.fill")
//                    .resizable()
                    .frame(width: iconWidth, height: iconWidth)
                  Text(row.info.user)
                }
                .font(.caption)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

                HStack(alignment: .firstTextBaseline) { // tags label
                  Image(systemName: "tag")
//                    .resizable()
                    .frame(width: iconWidth, height: iconWidth)
                  Text(row.info.tags)
                }
                .font(.caption2)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

              }
              .padding(.all, inSpacing)
              .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: imageWidth + (inSpacing * 2), alignment: .topLeading)

              // right-ish image block
              ImageView(image: FetchImage(url: row.info.previewURL, deps.photos))
                .frame(width: imageWidth, height: imageWidth)
                .cornerRadius(7)
                .clipped()
                //              .clipShape(ContainerRelativeShape())
                .shadow(color: Color(.black), radius: 10)
                .padding([.trailing, .top, .bottom], inSpacing)

            }
            .background(bgColor)
            .cornerRadius(11)
            .clipped()
            //          .onTapGesture {
            //            fatalError()
            //          }
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, outSpacing)
      }}
      .frame(minWidth: 300, idealWidth: 400, maxWidth: .infinity,
             minHeight: 300, idealHeight: 500, maxHeight: .infinity, alignment: .topLeading)
      .onAppear {
        deps.photos.topPopular(query: "cars") { result in
          isLoading = false

          switch result {
          case .success(let photos):
            data = photos.map {
              DataItem(info: $0)
            }
          case .failure(let err):
            // FIXME: err
            ()
          }
        }
      }
  }
  //.navigationBarTitle("Navigation")
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .frame(width: 500, height: 300, alignment: .center)
  }
}
