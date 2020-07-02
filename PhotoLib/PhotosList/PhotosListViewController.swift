//
//  ViewController.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotosListViewController: UIViewController {

  var viewModel: PhotosListViewModel!

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.dataSource = self
      collectionView.delegate = self
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(viewModel != nil)

    navigationItem.title = viewModel.title

    viewModel.topPopularCars { [weak self] success in
      if success {
        self?.collectionView.reloadData()
      }
      self?.activityIndicator.stopAnimating()
    }
  }

}

extension PhotosListViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.numberOfItems()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
      fatalError("Unregistered collection view cell")
    }

    cell.display(viewModel: viewModel.photoCellViewModel(at: indexPath))

    return cell
  }

}

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel.showPhotoDetails(at: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let minSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
    let totalWidth = collectionView.frame.width - collectionView.layoutMargins.left * 2 - minSpacing

    let width: CGFloat = totalWidth / 2
    let height: CGFloat = 90

    return CGSize(width: width, height: height)
  }

}

