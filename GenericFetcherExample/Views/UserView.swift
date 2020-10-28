//
//  UserView.swift
//  GenericFetcherExample
//
//  Created by Stuart on 24/10/2020.
//

import SwiftUI

struct UserView: View {
    
    @StateObject var viewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.viewData.viewState {
                case .loading:
                    Text("Loading")
                case .data:
                    List {
                        ForEach(viewModel.viewData.users) { user in
                            NavigationLink(destination: PostView(viewModel: PostViewModel(with: user.id) )) {
                                Text(user.name)
                            }
                        }
                    }
                case .noData:
                    Text("No data to display")
                case .error:
                    Text("Data error")
                }
            }
        }
        .onAppear {
            viewModel.loadUsers()
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = UserViewModel()
        return UserView(viewModel: viewModel)
    }
}
