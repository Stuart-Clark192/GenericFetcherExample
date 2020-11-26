//
//  Post.swift
//  GenericFetcherExample
//
//  Created by Stuart on 28/10/2020.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

struct PostTestData {
    
    static let postDataJSON =
"""
[
  {
      "userId": 1,
      "id": 1,
      "title": "Some Title",
      "body": "Body Text"
    }
]
"""
}
