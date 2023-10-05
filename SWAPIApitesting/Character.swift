//
//  Character.swift
//  SWAPIApitesting
//
//  Created by mahek on 04/10/2023.
//

import Foundation

struct Character: Codable {
    let name: String
    let birthYear: String
    let gender: String
    // Add other properties as needed

    // CodingKeys enum is used to map between Swift property names and JSON keys if they are different
    private enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case gender
        // Add other cases for other properties
    }
}
