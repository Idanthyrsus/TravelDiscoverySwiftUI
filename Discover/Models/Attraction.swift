//
//  Attraction.swift
//  Discover
//
//  Created by Alexander Korchak on 25.06.2023.
//

import Foundation

struct Attraction: Identifiable {
    var id = UUID().uuidString
    let name: String
    let imageName: String
    let latitude: Double
    let longitude: Double
}
