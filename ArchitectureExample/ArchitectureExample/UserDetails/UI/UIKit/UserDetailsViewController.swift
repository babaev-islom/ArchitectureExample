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
    
    private lazy var descriptionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .green
        btn.addTarget(self, action: #selector(btnTapped), for: .primaryActionTriggered)
        return btn
    }()
    
    private let onDataLoadRequest: () -> Void
    private let selection: () -> Void
    
    init(onDataLoadRequest: @escaping () -> Void, selection: @escaping () -> Void) {
        self.onDataLoadRequest = onDataLoadRequest
        self.selection = selection
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(ageLabel)
        view.addSubview(descriptionButton)
        
        onDataLoadRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            descriptionButton.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8),
            descriptionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    func didFinishLoading(details: UserDetailsItem) {
        ageLabel.text = details.age
        descriptionButton.setTitle(details.description, for: .normal)
    }
    
    @objc private func btnTapped() {
        selection()
    }
}

