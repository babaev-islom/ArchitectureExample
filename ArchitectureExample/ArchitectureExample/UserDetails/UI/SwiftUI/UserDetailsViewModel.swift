//
//  UserDetailsViewModel.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import Foundation

final class UserDetailsViewModel: ObservableObject {
    @Published private(set) var details: UserDetailsItem?
    
    func didFinishLoading(_ details: UserDetailsItem) {
        self.details = details
    }
}
