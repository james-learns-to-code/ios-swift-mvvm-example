//
//  StarwarsViewControllerWithXib.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsViewControllerWithXib: UIViewController {
    private let viewModel = StarwarsViewModel()

    @IBOutlet
    private weak var tableView: UITableView! {
        didSet {
            tableView.register(StarwarsFilmCell.self, forCellReuseIdentifier: "StarwarsFilmCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchApiList()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupBinding()
    }
    private func setupBinding() {
        viewModel.films.bind { [weak self] films in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension StarwarsViewControllerWithXib: UITableViewDelegate {
}

extension StarwarsViewControllerWithXib: UITableViewDataSource {
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
