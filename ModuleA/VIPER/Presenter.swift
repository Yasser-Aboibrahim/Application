//
//  Presenter.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import UtilitiesModule

protocol ModuleAPresenterProtocol: AnyObject {
    var view: ModuleAViewProtocol? {get set}
    var interactor: ModuleAInteractorProtocol? {get set}
    var router: ModuleARouterProtocol? {get set}
    
    func itemSelected(at index: Int)
    func showUniversities(_ universities: [University])
    func showError(message: String)
    func fetchUniversitiesData()
}

class ModuleAPresenter: ModuleAPresenterProtocol {
    var view: ModuleAViewProtocol?
    var interactor: ModuleAInteractorProtocol?
    var router: ModuleARouterProtocol?
    
    func itemSelected(at index: Int) {
        guard let uni = interactor?.getItem(at: index) else { return }
        router?.navigateToDetailsScreen(with: uni)
    }

    func fetchUniversitiesData() {
        interactor?.fetchItems()
    }

    func showUniversities(_ universities: [University]) {
        view?.showUniversities(universities)
    }

    func showError(message: String) {
        view?.showError(message: message)
    }
}
