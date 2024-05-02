//
//  University.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

struct University: Codable {
    let name: String
    let stateProvince: String?
    let domains: [String]
    let webPages: [String]
    let country: String
    let alphaTwoCode: String

    enum CodingKeys: String, CodingKey {
        case name
        case stateProvince = "state-province"
        case domains
        case webPages = "web_pages"
        case country
        case alphaTwoCode = "alpha_two_code"
    }

    private var payloadDic: [String: Any] {
        var payloadDictionary: [String: Any] = [:]
        payloadDictionary[JSONBody.name.rawValue] = self.name
        payloadDictionary[JSONBody.stateProvince.rawValue] = stateProvince
        payloadDictionary[JSONBody.domains.rawValue] = domains
        payloadDictionary[JSONBody.webPages.rawValue] = webPages
        payloadDictionary[JSONBody.country.rawValue] = country
        payloadDictionary[JSONBody.alphaTwoCode.rawValue] = alphaTwoCode
        return payloadDictionary
    }

    var data: Data? {
        let jsonData = try? JSONSerialization.data(withJSONObject: payloadDic, options: .prettyPrinted)
        return jsonData
    }
}
