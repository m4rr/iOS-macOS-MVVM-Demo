//
//  PhotoCell.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class PhotoCell: UICollectionViewCell {

  private var viewModel: PhotoCellViewModel?

  override func prepareForReuse() {
    super.prepareForReuse()

    viewModel = nil
    imageView.image = nil
    authorLabel.text = nil
    photoIdLabel.text = nil
  }

  func display(viewModel vm: PhotoCellViewModel) {
    self.viewModel = vm

    authorLabel.text = viewModel?.authorLabelText
    photoIdLabel.text = viewModel?.photoIdLabelText

    viewModel?.fetchImage { [weak viewModel, weak imageView] image in
      guard viewModel != nil, let imageView = imageView else {
        return
      }

      UIView.transition(with: imageView,
                        duration: 0.1,
                        options: .transitionCrossDissolve,
                        animations: {
                          imageView.image = image
      })
    }
  }
  
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var photoIdLabel: UILabel!
  @IBOutlet weak var imageView: ShImageView! {
    didSet {
      imageView.clipsToBounds = true
      imageView.layer.cornerCurve = .continuous
      imageView.layer.cornerRadius = 7
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    contentView.clipsToBounds = true
    contentView.layer.cornerCurve = .continuous
    contentView.layer.cornerRadius = 11
  }
  
}
