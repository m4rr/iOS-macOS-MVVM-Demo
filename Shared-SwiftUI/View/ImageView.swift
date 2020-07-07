//
//  ImageView.swift
//  Shared
//
//  Created by Marat Say on 7/6/20.
//

import SwiftUI

public struct ImageView: View {

  @ObservedObject // keeps object in memory
  var image: FetchImage

  public var body: some View {
    ZStack {
      Rectangle()
        .fill(bgColor)

      image.view?
        .resizable()
        .aspectRatio(contentMode: .fill)
    }
    .animation(.easeIn(duration: 0.15))
//    .onAppear(perform: image.fetch)
//    .onDisappear(perform: image.cancel)
  }

}

final class FetchImage: ObservableObject, Identifiable {

  let url: String

  @Published private(set) var image: PlatformImage?
  @Published private(set) var error: Error?
  @Published private(set) var isLoading: Bool = false

  deinit {
    cancel()
  }

  init(url: String, _ service: PhotosServiceProtocol) {
    self.url = url
    self.photoService = service

    self.fetch()
  }

  let photoService: PhotosServiceProtocol?

  func fetch() {
    guard !isLoading else {
      return
    }

    error = nil

    isLoading = true
    loadImage(url: url)
  }

  private func loadImage(url: String) {
    photoService?.fetchImage(url: url, completion: { [weak self] (image) in
      self?.didFinishRequest(result: image)
    })
  }

  private func didFinishRequest(result: PlatformImage?) {
    if let result = result {
      isLoading = false
      image = result
    } else {
      isLoading = false
    }
  }

  /// Marks the request as being cancelled.
  func cancel() {
    photoService?.cancelFetching(url: url)
    isLoading = false
  }
}

extension FetchImage {
  var view: SwiftUI.Image? {
    #if os(macOS)
    return image.map(Image.init(nsImage:))
    #else
    return image.map(Image.init(uiImage:))
    #endif
  }
}
