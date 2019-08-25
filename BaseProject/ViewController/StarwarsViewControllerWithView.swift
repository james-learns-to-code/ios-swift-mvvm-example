//
//  StarwarsViewControllerWithView.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsViewControllerWithView: UIViewController {
    private let viewModel = StarwarsViewModel()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(StarwarsFilmCell.self, forCellReuseIdentifier: "StarwarsFilmCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchApiList()
    }
    
    // MARK: Setup
    
    private func setup() {
        view.backgroundColor = .white
        addTableView()
        setupBind()
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }
    
    private func setupBind() {
        
        viewModel.films.bind = { [weak self] films in
            self?.tableView.reloadData()
        }
        
        viewModel.error.bind = { [weak self] error in
            guard let self = self else { return }
            UIAlertController.presentError(
                in: self,
                message: error?.localizedDescription
            ) { action in
                self.dismiss(animated: true)
            }
        }
    }
}

extension StarwarsViewControllerWithView: UITableViewDelegate {
}

extension StarwarsViewControllerWithView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarwarsFilmCell", for: indexPath) as! StarwarsFilmCell
        let film = viewModel.film(at: indexPath)
        cell.configure(film: film)
        return cell
    }
}
