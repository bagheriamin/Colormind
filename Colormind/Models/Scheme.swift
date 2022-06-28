//
//  Scheme.swift
//  Colormind
//
//  Created by Amin  Bagheri  on 2022-06-28.
//

import Foundation

struct Scheme: Codable {
    let colors: [SingleColor]
    let image: Image
}

struct SingleColor: Codable {
    let hex: Hex
    let name: Name
    let image: Image
}

struct Hex: Codable {
    let value: String
    let clean: String
}

struct Name: Codable {
    let value: String
}

struct Image: Codable {
    let bare: String
    let named: String
}
