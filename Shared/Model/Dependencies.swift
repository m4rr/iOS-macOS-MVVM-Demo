//
//  Dependencies.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

#if os(iOS)
import UIKit
typealias ShImage = UIImage
typealias ShColor = UIColor
#elseif os(macOS)
import AppKit
typealias ShImage = NSImage
typealias ShColor = NSColor
#endif

class Dependencies {

  let client: PixbAPINetworkClient
  let photos: PhotosServiceProtocol
  let cache: NSCache<PhotoCacheKey, ShImage>

  init() {
    client = PixbAPINetworkClient()
    cache = NSCache<PhotoCacheKey, ShImage>()
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
