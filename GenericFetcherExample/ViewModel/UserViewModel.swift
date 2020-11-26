//
//  UserViewModel.swift
//  GenericFetcherExample
//
//  Created by Stuart on 27/10/2020.
//

import SwiftUI
import Combine

struct UserViewModelPublished {
    var users: [User] = []
    var viewState: ViewState = .noData
}

class UserViewModel: ObservableObject {
    
    typealias UserResponse = AnyPublisher<[User], APIError>
    
    @Published private(set) var viewData = UserViewModelPublished()
    
    private var worker = GenericWorker()
    private var cancellationToken: AnyCancellable?
    private var session: URLSession!
    private var request: UserResponse!
    
    init(using session: URLSession = AppSession.sharedInstance.session) {
        self.session = session
    }
    
    func loadUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        request = worker.fetch(url: url, httpMethod: .get, using: session)
        viewData.viewState = .loading
        
        cancellationToken = request
            .receive(on: DispatchQueue.main) // We want to receive this on the main queue so we can update
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.viewData.viewState = .error
                }
            },
            receiveValue: { [weak self] model in
                self?.viewData.viewState = model.isEmpty ? .noData : .data
                self?.viewData.users = model
            })
    }
}

