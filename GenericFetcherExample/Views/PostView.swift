//
//  PostView.swift
//  GenericFetcherExample
//
//  Created by Stuart on 28/10/2020.
//

import SwiftUI

struct PostView: View {
    @StateObject var viewModel: PostViewModel
    
    var body: some View {
        Group {
            switch viewModel.viewData.viewState {
            case .loading:
                Text("Loading")
            case .data:
                List {
                    ForEach(viewModel.viewData.posts) { post in
                        Text(post.title)
                    }
                }
            case .noData:
                Text("No data to display")
            case .error:
                Text("Data error")
            }
        }
        .onAppear {
            viewModel.loadPosts()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PostViewModel(with: 2)
        PostView(viewModel: viewModel)
    }
}
