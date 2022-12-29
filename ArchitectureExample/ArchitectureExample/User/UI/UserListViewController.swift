//
//  UserListViewController.swift
//  ArchitectureExample
//
//  Created by Islom on 29/12/22.
//

import UIKit

final class UserListViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = UIRefreshControl()
        return tableView
    }()
    
    private let onDataLoadRequest: () -> Void
    
    private var users = [UserItem]() {
        didSet { tableView.reloadData() }
    }
    
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
        view.addSubview(tableView)
        onDataLoadRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
     
    func didStartLoading(isLoading: Bool) {
        isLoading ? tableView.refreshControl?.beginRefreshing() : tableView.refreshControl?.endRefreshing()
    }
    
    func didFinishLoading(users: [UserItem]) {
        self.users = users
    }
    
    func didFinishLoading(with error: String) {
        let alert = UIAlertController(title: "Error occurred", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        user.selection()
    }
}
