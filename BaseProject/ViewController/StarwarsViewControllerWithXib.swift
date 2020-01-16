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
            tableView.register(UINib(nibName: "StartwarsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "StartwarsHeaderView")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchApiList()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupBind()
    }
    private func setupBind() {
        tableView.allowsMultipleSelection = false
        
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // For using custom view
//        guard let xibName = String(describing: StartwarsHeaderView.self).components(separatedBy: ".").last else { return nil }
//        guard let _ = Bundle.main.path(forResource: xibName, ofType: "nib") else { return nil } // check xib exists.
//        return Bundle.main.loadNibNamed(xibName, owner: nil, options: nil)?.first as? StartwarsHeaderView

        // For using registed header view
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "StartwarsHeaderView")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
