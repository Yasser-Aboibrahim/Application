//
//  Presenter.swift
//  ModuleB
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import UtilitiesModule

protocol ModuleBPresenterProtocol: AnyObject {
    var view: ModuleBViewProtocol? {get set}
    var router: ModuleBRouterProtocol? {get set}
    func viewDidLoad()
    func dismissDetailsScreeen()
}

class ModuleBPresenter: ModuleBPresenterProtocol {
    var view: ModuleBViewProtocol?
    var router: ModuleBRouterProtocol?
    var university: University?

    init(university: University? = nil) {
        self.university = university
    }

    func viewDidLoad() {
        guard let university = university else { return }
        view?.showItemDetails(university)
    }

    func dismissDetailsScreeen() {
        router?.dismissDetailsScreen()
    }
}
