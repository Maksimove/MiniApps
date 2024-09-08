//
//  Weather.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 04.09.2024.
//


import Foundation

struct Weather: Decodable {
    let location: Location
    let current: Current
}

struct Location: Decodable {
    let name, country: String
}

struct Current: Decodable {
    let tempC: Double
    let condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition = "condition"
    }
}

struct Condition: Decodable {
    let text, icon: String
}


