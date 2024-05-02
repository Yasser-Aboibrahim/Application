//
//  Interactor.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

protocol ModuleADataManagerProtocol {
    func fetchItemsFromAPI(completion: @escaping (Result<[University], Error>) -> Void)
}

protocol ModuleAInteractorProtocol: AnyObject {
    var presenter: ModuleAPresenterProtocol? {get set}
    func fetchItems()
    func getItem(at index: Int) -> University
}

class ModuleAInteractor: ModuleAInteractorProtocol {
    weak var presenter: ModuleAPresenterProtocol?
    var dataManager = DataManager()


    func fetchItems() {
        dataManager.fetchItemsFromAPI { result in
            switch result {
            case .success(let universities):
                self.dataManager.coreData.deleteAllData()
                self.presenter?.showUniversities(universities)
                self.dataManager.coreData.insert(universities: universities)
            case .failure(let error):
                self.presenter?.showError(message: error.localizedDescription)
                self.presenter?.showUniversities(self.dataManager.coreData.fetchAllData() ?? [])
            }
        }
    }
    
    func getItem(at index: Int) -> University {
        // Fetch item from local DB
        return University(name: "", stateProvince: "", domains: [""], webPages: [""], country: "", alphaTwoCode: "")
    }
}
