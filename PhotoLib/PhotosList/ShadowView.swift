//
//  ShadowView.swift
//  PhotoLib
//
//  Created by Marat Saytakov on 6/30/20.
//

import UIKit

class ShadowView: UIView {

  override func layoutSubviews() {
    super.layoutSubviews()

    clipsToBounds = false
    layer.shadowColor = UIColor.label.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 5
    layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
  }

}
