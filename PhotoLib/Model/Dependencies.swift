//
//  Dependencies.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class Dependencies {

  let client: PixbAPINetworkClient
  let photos: PhotosServiceProtocol
  let cache: NSCache<PhotoCacheKey, UIImage>

  init() {
    client = PixbAPINetworkClient()
    cache = NSCache<PhotoCacheKey, UIImage>()
    photos = PhotosService(client: client, cache: cache)
  }
}

class PhotoCacheKey: NSObject {

  private let key: String

  init(key: String) {
    self.key = key

    super.init()
  }

  override var hash: Int {
    return key.hash
  }

  override func isEqual(_ object: Any?) -> Bool {
    guard let other = object as? PhotoCacheKey else {
      return false
    }

    return self.key == other.key
  }
}
