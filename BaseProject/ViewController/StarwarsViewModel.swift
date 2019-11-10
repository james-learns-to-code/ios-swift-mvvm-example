//
//  StarwarsViewModel.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class StarwarsViewModel {
    
    let films = UIBindable<StarwarsFilmsModel>()
    let error = UIBindable<NetworkError>()
    
    func film(at indexPath: IndexPath) -> StarwarsFilmModel? {
        films.value?.results?[indexPath.row]
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        films.value?.results?.count ?? 0
    }
    
    // MARK: API
    func fetchApiList() {
        API.shared.requestFilmList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.films.value = value
            case .failure(let error):
                self.error.value = error
            }
        }
    }
}
