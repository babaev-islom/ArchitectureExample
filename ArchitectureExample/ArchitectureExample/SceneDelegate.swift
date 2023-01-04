//
//  SceneDelegate.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit
import Combine

private extension APIClient {
    func requestPublisher(_ request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
        Deferred {
            Future { completion in
                send(request, completion: completion)
            }
        }.eraseToAnyPublisher()
    }
}

final class RandomCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        navigationController.pushViewController(vc, animated: true)
    }
}


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        showUsersList(scene)
    }
    
    private func showUsersList(_ scene: UIWindowScene) {
        let apiClient = APIClientStub()
        let navigationController = UINavigationController()
        let factory = UserListCoordinatorFactory(
            url: URL(string: "https://any-url.com")!,
            requestPublisher: apiClient.requestPublisher
        )
        let coordinator = UserListCoordinator(
            navigationController: navigationController,
            factory: factory,
            makeUserDetailsCoordinator: makeUserDetailsCoordinator
        )
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator.start()
    }
    
    private func makeUserDetailsCoordinator(_ navController: UINavigationController, user: User) -> Coordinator {
        let apiClient2 = APIClientStub2()
        let factory = UIKitUserDetailsCoordinatorFactory(user: user, apiClient: apiClient2)
        let coordinator = UserDetailsCoordinator(navigationController: navController, factory: factory, makeRandomCoordinator: makeRandomCoordinator)
        return coordinator
    }
    
    private func makeRandomCoordinator(_ navController: UINavigationController) -> Coordinator {
        RandomCoordinator(navigationController: navController)
    }
    
//    private func showUIKitUserDetails(user: User) {
//        let url = URL(string: "https://any-url.com/details")!
//        let apiClientStub = APIClientStub2()
//        let remoteLoader = RemoteUserDetailsLoader(url: url, client: apiClientStub)
//        let vc = UIKitUserDetailsFactory.makeUserDetailsListViewController(with: user, loader: remoteLoader)
//        navigationController.pushViewController(vc, animated: true)
//    }
//
//    private func showSwiftUIUserDetails(user: User) {
//        let url = URL(string: "https://any-url.com/details")!
//        let apiClientStub = APIClientStub2()
//        let remoteLoader = RemoteUserDetailsLoader(url: url, client: apiClientStub)
//        let vc = SwiftUIUserDetailsFactory.makeUserDetailsListViewController(with: user, loader: remoteLoader)
//        navigationController.pushViewController(vc, animated: true)
//    }
}

