//
//  Models.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import Foundation

struct PhotoInfo: Decodable {

  let id: Int
  let comments: Int
  let downloads: Int
  let favorites: Int
  let likes: Int
  let largeImageURL: String
  let tags: String
  let views: Int
  let user: String
  let previewURL: String

}
