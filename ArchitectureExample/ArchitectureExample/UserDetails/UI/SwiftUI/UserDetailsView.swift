//
//  UserDetailsView.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import SwiftUI

struct UserDetailsView: View {
    @ObservedObject var viewModel: UserDetailsViewModel
    let onDataLoadRequest: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            if let details = viewModel.details {
                Text(details.age)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Text(details.description)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.red)
            }
            
            Spacer()
        }.onAppear(perform: onDataLoadRequest)
    }
}
