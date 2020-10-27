//
//  GenericWorkerTests.swift
//  GenericFetcherExampleTests
//
//  Created by Stuart on 27/10/2020.
//

import XCTest
import Combine
@testable import GenericFetcherExample

class GenericWorkerTests: XCTestCase {
    
    typealias UserResponse = AnyPublisher<[User], APIError>

    private var sut = GenericWorker()
    private var session = URLTestSession.testSession()
    private var url: URL!
    private var request: UserResponse!
    
    override func setUpWithError() throws {
        url = try XCTUnwrap(URL(string: "https://jsonplaceholder.typicode.com/users"))
        request = sut.fetch(url: url, httpMethod: .get, using: session)
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testFetchUsersWithValidResponseReturnsData() throws {
        URLProtocolMock.response = MockResponses.validResponse
        
        let validTest = evalValidResponse(publisher: request, description: #function)
        wait(for: validTest.expectations, timeout: 10)
        validTest.cancellable?.cancel()
    }
    
    func testFetchUsersWithInValidResponseReturnsError() throws {
        URLProtocolMock.response = MockResponses.urlNotFoundResponse
        
        let invalidTest = evalInvalidResponse(publisher: request, description: #function)
        wait(for: invalidTest.expectations, timeout: 10)
        invalidTest.cancellable?.cancel()
    }

}
