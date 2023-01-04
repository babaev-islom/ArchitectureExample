//
//  UserListFactory.swift
//  ArchitectureExample
//
//  Created by Islom on 04/01/23.
//

import UIKit
import Combine

protocol UserListFactory {
    func makeUserListViewController(selection: @escaping (User) -> Void) -> UIViewController
}

final class UserListCoordinatorFactory: UserListFactory {
    private let url: URL
    private let requestPublisher: (URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
    
    init(
        url: URL,
        requestPublisher: @escaping (URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error>
    ) {
        self.url = url
        self.requestPublisher = requestPublisher
    }
    
    func makeUserListViewController(selection: @escaping (User) -> Void) -> UIViewController {
        let request = URLRequest(url: url)
        let vc = UserFactory.makeUserListViewController(
            loader: { [requestPublisher] in
                requestPublisher(request)
                    .tryMap(UserMapper.map)
                    .eraseToAnyPublisher()
            },
            selection: selection
        )
        return vc
    }
}
