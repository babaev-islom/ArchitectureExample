//
//  SceneDelegate.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private lazy var navigationController = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        showUsersList()
    }
    
    private func showUsersList() {
        let url = URL(string: "https://any-url.com")!
        let apiClientStub = APIClientStub()
        let remoteLoader = RemoteUserLoader(url: url, client: apiClientStub)
        let vc = UserFactoryWithViewModel.makeUserListViewController(loader: remoteLoader, selection: showSwiftUIUserDetails)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showUIKitUserDetails(user: User) {
        let url = URL(string: "https://any-url.com/details")!
        let apiClientStub = APIClientStub2()
        let remoteLoader = RemoteUserDetailsLoader(url: url, client: apiClientStub)
        let vc = UIKitUserDetailsFactory.makeUserDetailsListViewController(with: user, loader: remoteLoader)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func showSwiftUIUserDetails(user: User) {
        let url = URL(string: "https://any-url.com/details")!
        let apiClientStub = APIClientStub2()
        let remoteLoader = RemoteUserDetailsLoader(url: url, client: apiClientStub)
        let vc = SwiftUIUserDetailsFactory.makeUserDetailsListViewController(with: user, loader: remoteLoader)
        navigationController.pushViewController(vc, animated: true)
    }
}

