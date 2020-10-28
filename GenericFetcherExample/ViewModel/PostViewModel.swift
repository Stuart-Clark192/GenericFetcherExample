//
//  PostViewModel.swift
//  GenericFetcherExample
//
//  Created by Stuart on 28/10/2020.
//

import SwiftUI
import Combine

struct PostViewModelPublished {
    var posts: [Post] = []
    var viewState: ViewState = .noData
}

class PostViewModel: ObservableObject {
    
    typealias UserResponse = AnyPublisher<[Post], APIError>
    
    @Published private(set) var viewData = PostViewModelPublished()
    
    private var worker = GenericWorker()
    private var cancellationToken: AnyCancellable?
    private var session: URLSession!
    private var request: UserResponse!
    private var userId = -1
    
    init(with userId: Int, session: URLSession = AppSession.sharedInstance.session) {
        self.session = session
        self.userId = userId
    }
    
    func loadPosts() {
        let urlString = "https://jsonplaceholder.typicode.com/posts?userId=\(userId)"
        guard let url = URL(string: urlString) else { return }
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
                self?.viewData.posts = model
            })
    }
}

