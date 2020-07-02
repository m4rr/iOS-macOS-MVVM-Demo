//
//  PhotosListViewModel.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotosListViewModel {
  
  private let photos: PhotosServiceProtocol
  private let client: PixbAPINetworkClient
  private let router: RouterProtocol
  
  private var data: [PhotoInfo] = []
  
  init(photos: PhotosServiceProtocol,
       client: PixbAPINetworkClient,
       router: RouterProtocol) {
    
    self.photos = photos
    self.client = client
    self.router = router
  }

  func topPopularCars(completion handler: @escaping (Bool) -> Void) {

    guard data.isEmpty else {
      handler(true)
      return
    }

    photos.topPopular(query: "cars") { result in
      switch result {
      case .failure(let err):
        DispatchQueue.main.async {
          self.router.showError(text: err.localizedDescription)
          
          handler(false)
        }
      case .success(let data):
        DispatchQueue.main.async {
          self.data = data
          handler(true)
        }
      }
    }
  }
  
  func showPhotoDetails(at indexPath: IndexPath)  {
    router.showPhotoDetails(photoInfo: data[indexPath.item])
  }
  
  func numberOfItems() -> Int {
    data.count
  }
  
  func photoCellViewModel(at indexPath: IndexPath) -> PhotoCellViewModel {
    PhotoCellViewModel(photos: photos, photoInfo: data[indexPath.item])
  }
  
  let title = "Photo Lib"

}
