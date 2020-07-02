//
//  Router.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

protocol RouterProtocol {
  func showPhotoDetails(photoInfo: PhotoInfo) 
  func showError(text: String)
}

class Router: RouterProtocol {
  private let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
  private let dependencies = Dependencies()
  
  private var navigationController: UINavigationController?
  
  func rootViewController() -> UIViewController {
    let vc: PhotosListViewController = mainStoryboard.instantiate(type: PhotosListViewController.self)
    let viewModel = PhotosListViewModel(photos: dependencies.photos,
                                        client: dependencies.client,
                                        router: self)
    vc.viewModel = viewModel

    let nav = UINavigationController(rootViewController: vc)
    nav.navigationBar.prefersLargeTitles = true
    self.navigationController = nav

    return nav
  }
  
  func showPhotoDetails(photoInfo: PhotoInfo) {
    let vc = PhotoDetailsViewController(style: .insetGrouped)
    vc.modalPresentationStyle = .custom
    vc.modalTransitionStyle = .coverVertical
    vc.transitioningDelegate = vc.photoDetailsTansitioningDelegate

    let viewModel = PhotoDetailsViewModel(photoInfo: photoInfo)
    vc.viewModel = viewModel

    navigationController?.present(vc, animated: true)
  }
  
  func showError(text: String) {
    let vc = UIAlertController(title: text, message: nil, preferredStyle: .alert)
    vc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    navigationController?.present(vc, animated: true, completion: nil)
  }

}

