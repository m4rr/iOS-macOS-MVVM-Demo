//
//  PhotoDetailsPresentationController.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotoDetailsPresentationController: UIPresentationController {

  override var frameOfPresentedViewInContainerView: CGRect {
    var newFrame = super.frameOfPresentedViewInContainerView
    newFrame.size.height /= 2
    newFrame.origin.y = newFrame.size.height

    return newFrame
  }

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {

    super.init(presentedViewController: presentedViewController,
               presenting: presentingViewController)
  }

}
