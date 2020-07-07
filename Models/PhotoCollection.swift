//
//  Models.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import Foundation

struct PhotosCollection: Decodable {

  let hits: [PhotoInfo]
  let total: Int

}
