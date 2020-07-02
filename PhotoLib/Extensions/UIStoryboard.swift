//
//  UIStoryboard.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

extension UIStoryboard {
  func instantiate<T: UIViewController>(type: T.Type) -> T {
    return instantiateViewController(withIdentifier: String(describing: type)) as! T
  }
}

