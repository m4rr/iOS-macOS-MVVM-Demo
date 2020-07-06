//
//  PhotoCellViewModel.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotoCellViewModel {

  var authorLabelText: String {
    photoInfo.user
  }

  var photoIdLabelText: String {
    photoInfo.tags
  }
  
  private let photos: PhotosServiceProtocol
  private let photoInfo: PhotoInfo
  
  init(photos: PhotosServiceProtocol, photoInfo: PhotoInfo) {
    self.photos = photos
    self.photoInfo = photoInfo
  }

  func fetchImage(completion handler: @escaping (UIImage?) -> Void) {
    photos.fetchImage(url: photoInfo.previewURL, completion: handler)
  }

  func cancelFetching() {
    photos.cancelFetching(url: photoInfo.previewURL)
  }

  deinit {
    cancelFetching()
  }
  
}
