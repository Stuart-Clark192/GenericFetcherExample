//
//  URLTestSession.swift
//  GenericFetcherExample
//
//  Created by Stuart on 27/10/2020.
//

import Foundation

struct URLTestSession {
    static func testSession() -> URLSession {
        
        guard let userURL = URL(string: "https://jsonplaceholder.typicode.com/users") else { return URLSession.shared }
        let userTestData = UserTestData.usersDataJSON.data(using: .utf8)!
        
        guard let postURL = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=1") else { return URLSession.shared }
        let postTestData = PostTestData.postDataJSON.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [userURL: userTestData, postURL: postTestData]
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}
