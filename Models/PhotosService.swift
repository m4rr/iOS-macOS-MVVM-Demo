//
//  PhotosService.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

protocol PhotosServiceProtocol {
  
  func topPopular(query: String, completion handler: @escaping (Result<[PhotoInfo], APIError>) -> Void)
  
  func fetchImage(url: String, completion handler: @escaping (PlatformImage?) -> Void)

  func cancelFetching(url: String)
}

class PhotosService: PhotosServiceProtocol {
  
  private let client: PixbAPINetworkClient
  private let cache: NSCache<PhotoCacheKey, PlatformImage>
  private var fetchingTasks: [String: URLSessionDataTask] = [:]

  init(client: PixbAPINetworkClient, cache: NSCache<PhotoCacheKey, PlatformImage>) {
    self.client = client
    self.cache = cache
  }

  func topPopular(query: String, completion handler: @escaping (Result<[PhotoInfo], APIError>) -> Void) {
    client.fetchImageList(for: query, completion: handler)
  }

  func cancelFetching(url: String) {
    fetchingTasks.removeValue(forKey: url)?.cancel()
  }

  func fetchImage(url: String, completion handler: @escaping (PlatformImage?) -> Void) {

    let cacheKey = PhotoCacheKey(key: url)
    
    if let cachedImage = cache.object(forKey: cacheKey) {
      handler(cachedImage)
      
      return
    }
    
    let task = client.fetchImage(on: url) { [weak self] result in
      switch result {
      case .success(let image):
        self?.cache.setObject(image, forKey: cacheKey)
        
        DispatchQueue.main.async {
          handler(image)
        }
        
      case .failure:
        DispatchQueue.main.async {
          handler(nil)
        }
      }
    }

    fetchingTasks[url] = task
  }
}
