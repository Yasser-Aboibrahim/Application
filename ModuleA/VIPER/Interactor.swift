//
//  Interactor.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import UtilitiesModule

protocol ModuleADataManagerProtocol {
    func fetchItemsFromAPI(completion: @escaping (Result<[University], Error>) -> Void)
}

protocol ModuleAInteractorProtocol: AnyObject {
    var presenter: ModuleAPresenterProtocol? {get set}
    func fetchItems()
    func getItem(at index: Int) -> University?
}

class ModuleAInteractor: ModuleAInteractorProtocol {
    weak var presenter: ModuleAPresenterProtocol?
    var dataManager = DataManager()
    var universities: [University] = []

    func fetchItems() {
        dataManager.fetchItemsFromAPI { result in
            switch result {
            case .success(let universities):
                self.dataManager.coreData.deleteAllData()
                self.presenter?.showUniversities(universities)
                self.dataManager.coreData.insert(universities: universities)
                self.universities = universities
            case .failure(let error):
                if let universities = self.dataManager.coreData.fetchAllData(), !universities.isEmpty  {
                    self.presenter?.showUniversities(universities)
                    self.universities = universities
                } else {
                    self.presenter?.showError()
                }
            }
        }
    }
    
    func getItem(at index: Int) -> University? {
        return universities[index]
    }
}
