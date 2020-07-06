//
//  Constants.swift
//  PhotoLibrary
//
//  Created by Marat Say on 7/2/20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// API URL
let apiURL = "https://pixa" + "bay.com" + "/api/"

/// Pixb Key
let apiKey = "15333185-" + (Bundle.main.object(forInfoDictionaryKey: "KEY") as? String ?? "no key")

/// App's tint color
let windowTintColor = ShColor.systemGray

let firstPage = 1
