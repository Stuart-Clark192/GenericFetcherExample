//
//  SceneDelegate.swift
//  GenericFetcherExample
//
//  Created by Stuart on 24/10/2020.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let viewModel = UserViewModel()
        let userView = UserView(viewModel: viewModel)
        
        if let windowScene = scene as? UIWindowScene {
            
            if !AppSession.isRunningLocalData {
                
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: userView)
                self.window = window
                window.makeKeyAndVisible()
            } else {
                print("Running Tests")
            }
        }
    }
}
