//
//  Constants.swift
//  PhotoLibrary
//
//  Created by Marat Say on 7/2/20.
//

import SwiftUI

#if os(iOS)

import UIKit

let bgColor = Color(.tertiarySystemGroupedBackground)
let itemMinWidth: CGFloat = 160

/// non-SwiftUI App's tint color
let windowTintColor = UIColor.systemGray

#elseif os(macOS)

import AppKit

let bgColor = Color(.gridColor)
let itemMinWidth: CGFloat = 200

#endif

/// API URL
let apiURL = "https://pixa" + "bay.com" + "/api/"

/// Pixb Key
let apiKey = "15333185-" + (Bundle.main.object(forInfoDictionaryKey: "KEY") as? String ?? "no___key")

let photoWidth: CGFloat = 80
let iconWidth: CGFloat = 8
let innerSpace: CGFloat = 8
let outerSpace: CGFloat = 7
