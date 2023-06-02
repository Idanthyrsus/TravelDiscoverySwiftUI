//
//  Place.swift
//  Discover
//
//  Created by Alexander Korchak on 03.05.2023.
//

import Foundation

struct Place: Decodable, Hashable {
    let name, thumbnail: String
    let id: Int
}
