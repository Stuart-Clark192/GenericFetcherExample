//
//  User.swift
//  GenericFetcherExample
//
//  Created by Stuart on 27/10/2020.
//

import Foundation

struct User: Codable, Identifiable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat: String
    let lng: String
}

// MARK: - Company
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

struct UserTestData {
    
    static let usersDataJSON =
"""
[
  {
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
      "name": "Romaguera-Crona",
      "catchPhrase": "Multi-layered client-server neural-net",
      "bs": "harness real-time e-markets"
    }
  }
]
"""
}
