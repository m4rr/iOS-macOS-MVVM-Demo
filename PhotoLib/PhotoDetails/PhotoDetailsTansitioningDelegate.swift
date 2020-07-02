//
//  PhotoDetailsTansitioningDelegate.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotoDetailsTansitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

  func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

    PhotoDetailsPresentationController(presentedViewController: presented,
                                       presenting: presenting)
  }
  
}
