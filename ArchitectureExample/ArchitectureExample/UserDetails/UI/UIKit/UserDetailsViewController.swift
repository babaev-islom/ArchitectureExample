//
//  UserDetailsViewController.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

final class UserDetailsViewController: UIViewController {
    private let ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .gray
        return lbl
    }()
    
    private let descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .red
        return lbl
    }()
    
    private let onDataLoadRequest: () -> Void
    
    init(onDataLoadRequest: @escaping () -> Void) {
        self.onDataLoadRequest = onDataLoadRequest
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(ageLabel)
        view.addSubview(descriptionLabel)
        
        onDataLoadRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func didFinishLoading(details: UserDetailsItem) {
        ageLabel.text = details.age
        descriptionLabel.text = details.description
    }
}

