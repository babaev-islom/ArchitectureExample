//
//  UserListViewModel.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserListViewModel {
    var isLoading: ((Bool) -> Void)?
    var onDataLoad: (([UserItem]) -> Void)?
    var onLoadError: ((String) -> Void)?
    
    func didStartLoading() {
        isLoading?(true)
    }
    
    func didFinishLoading(items: [UserItem]) {
        isLoading?(false)
        onDataLoad?(items)
    }
    
    func didFinishLoading(with error: Error) {
        isLoading?(false)
        onLoadError?(error.localizedDescription)
    }
}
