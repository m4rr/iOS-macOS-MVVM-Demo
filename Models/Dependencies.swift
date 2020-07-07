//
//  Dependencies.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

#if os(iOS)
import UIKit
typealias PlatformImage = UIImage
#elseif os(macOS)
import AppKit
typealias PlatformImage = NSImage
#endif

class Dependencies {

  let client: PixbAPINetworkClient
  let photos: PhotosServiceProtocol
  let cache: NSCache<PhotoCacheKey, PlatformImage>

  init() {
    client = PixbAPINetworkClient()
    cache = NSCache<PhotoCacheKey, PlatformImage>()
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
