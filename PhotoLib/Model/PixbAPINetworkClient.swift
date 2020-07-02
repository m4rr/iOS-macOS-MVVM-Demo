//
//  PixbAPINetworkClient.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

enum APIError: Swift.Error {
  case objectWasUnexpectedlyDeallocated
  case failedToCreateURL
  case invalidResponse(response: URLResponse?)
  case networkError(error: Swift.Error, response: URLResponse?)
  case parsingError(error: Swift.Error)
}

class PixbAPINetworkClient {

  private let urlSession = URLSession.shared

  private func composeURL(_ params: [String: String]) -> URL? {
    var components = URLComponents(string: apiURL)
    components?.queryItems = params.map {
      URLQueryItem(name: $0, value: $1)
    }

    return components?.url
  }

  func fetchImageList(for query: String, completion: @escaping (Result<[PhotoInfo], APIError>) -> Void) {

    let imageType = "photo"
    let pageSize = 100

    guard let url = composeURL(["key": apiKey, "q": query, "image_type": imageType, "per_page": String(pageSize)]) else {
      completion(.failure(.failedToCreateURL))
      return
    }

    urlSession.dataTask(with: url) {  [weak self] (jsonData, response, error) in
      guard let self = self else {
        completion(.failure(.objectWasUnexpectedlyDeallocated))
        return
      }
      let result: Result<PhotosCollection, APIError> = self.handleResponse(data: jsonData, error: error, response: response)
      completion(result.map { $0.hits })
    }.resume()
  }

  func fetchImage(on urlString: String, completion: @escaping (Result<UIImage, APIError>) -> Void) -> URLSessionDataTask? {
    guard let url = URL(string: urlString) else {
      completion(.failure(.failedToCreateURL))
      return nil
    }

    let task = urlSession.dataTask(with: url) { (jsonData, response, error) in
      if let error = error {
        completion(.failure(.networkError(error: error, response: response)))
      }

      if let image = jsonData.flatMap(UIImage.init(data:)) {
        completion(.success(image))
      } else {
        let decodingError = NSError(domain: "com.photoLib.NetworkClient", code: -1, userInfo: nil)
        completion(.failure(.parsingError(error: decodingError)))
      }
    }

    task.resume()

    return task
  }

  private func handleResponse<Type: Decodable>(
    data: Data?, error: Swift.Error?, response: URLResponse?) -> Result<Type, APIError> {
    if let error = error {
      return .failure(.networkError(error: error, response: response))
    }

    if let jsonData = data {
      do {
        return .success(try JSONDecoder().decode(Type.self, from: jsonData))
      } catch {
        return .failure(.parsingError(error: error))
      }
    } else {
      return .failure(.invalidResponse(response: response))
    }
  }

}
