//
//  PhotoDetailsView.swift
//  PhotoLib
//
//  Created by Marat Say on 7/7/20.
//

import SwiftUI

struct PhotoDetailsView: View {

  @ObservedObject var viewModel: PhotoDetailsViewModel

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct PhotoDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    PhotoDetailsView(viewModel: PhotoDetailsViewModel())
  }
}
