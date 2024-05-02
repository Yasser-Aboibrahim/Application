//
//  DataManager.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import UtilitiesModule

class DataManager: ModuleADataManagerProtocol {
    var coreData = CoreDataManager()

    func fetchItemsFromAPI(completion: @escaping (Result<[University], Error>) -> Void) {
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            // Create URLSession
            let session = URLSession.shared
            
            // Create data task
            let task = session.dataTask(with: url) { data, response, error in
                // Check for errors
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                // Check if data is available
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                    return
                }
                
                // Decode JSON data
                do {
                    let decoder = JSONDecoder()
                    // Decode response into UniversityResponse struct
                    let universities = try decoder.decode([University].self, from: data)
                    completion(.success(universities))
                } catch {
                    completion(.failure(error))
                }
            }
            
            // Start the data task
            task.resume()
    }
}
