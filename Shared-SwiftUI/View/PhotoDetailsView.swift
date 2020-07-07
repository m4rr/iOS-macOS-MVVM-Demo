//
//  PhotoDetailsView.swift
//  PhotoLib
//
//  Created by Marat Say on 7/7/20.
//

import SwiftUI

struct PhotoDetailsView: View {

  @Binding var isPresented: Bool

  var viewModel: PhotoDetailsViewModel

  var body: some View {

    VStack {

      HStack {
        Text(viewModel.titleForHeaderInSection(0))
          .font(.headline)
        Spacer()
      }
      .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 14)

      List(viewModel.tableData, id: \.title) { item in
        HStack {
          Text(item.title)
          Spacer()
          Text(item.value)
        }
      }

    }
    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    .onTapGesture {
      isPresented.toggle()
    }
  }

}

//struct PhotoDetailsView_Previews: PreviewProvider {
//  static var previews: some View {
//    PhotoDetailsView(viewModel: PhotoDetailsViewModel(info: PhotoInfo()))
//  }
//}
