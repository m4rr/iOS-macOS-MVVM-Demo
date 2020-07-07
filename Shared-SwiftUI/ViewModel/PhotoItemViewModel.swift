//
//  PhotoItemViewModel.swift
//  PhotoLib
//
//  Created by Marat Say on 7/7/20.
//

import SwiftUI

final class PhotoItemViewModel: ObservableObject {

  var mainLabelText: String {
    info.user
  }

  var secondLabelText: String {
    info.tags
  }

  var imageURL: String {
    info.previewURL
  }

  let info: PhotoInfo
  let photoService: PhotosServiceProtocol

  init(info: PhotoInfo, _ service: PhotosServiceProtocol) {
    self.info = info
    self.photoService = service
  }

}
