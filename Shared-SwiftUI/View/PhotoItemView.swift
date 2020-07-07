//
//  PhotoItemView.swift
//  PhotoLib
//
//  Created by Marat Say on 7/7/20.
//

import SwiftUI

struct PhotoItemView: View {

  @ObservedObject var viewModel: PhotoItemViewModel

  var body: some View {

    ZStack {

      // squircle background to not clip shadow
      Rectangle()
        .fill(bgColor)
        .cornerRadius(11)
        .clipped()

      // cell content
      HStack(alignment: .top) {

        // left-ish text block
        VStack(alignment: .leading, spacing: innerSpace) {

          // user label
          HStack(alignment: .firstTextBaseline, spacing: innerSpace) {
            Image(systemName: "person.fill")
              .frame(width: iconWidth, height: iconWidth)
            Text(viewModel.mainLabelText)
          }
          .font(.caption)
          .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

          // tags label
          HStack(alignment: .firstTextBaseline) {
            Image(systemName: "tag")
              .frame(width: iconWidth, height: iconWidth)
            Text(viewModel.secondLabelText)
          }
          .foregroundColor(.gray)
          .font(.caption2)
          .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)

        }
        .padding(.all, innerSpace)
        .frame(maxWidth: .infinity, maxHeight: photoWidth + (innerSpace * 2), alignment: .topLeading)

        // right-ish image block
        ImageView(image: FetchImage(url: viewModel.imageURL, viewModel.photoService))
          .frame(width: photoWidth, height: photoWidth)
          .cornerRadius(7)
          .clipped()
          //.clipShape(ContainerRelativeShape())
          .shadow(color: .black, radius: 7)
          .padding([.trailing, .top, .bottom], innerSpace)

      }

    } // zstack

  }

}

//struct PhotoItemView_Previews: PreviewProvider {
//  static var previews: some View {
//    PhotoItemView(viewModel: PhotoItemViewModel(info: PhotoInfo(), PhotosService(client: <#PixbAPINetworkClient#>, cache: <#NSCache<PhotoCacheKey, PlatformImage>#>)))
//  }
//}
