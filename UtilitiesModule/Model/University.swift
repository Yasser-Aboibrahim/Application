//
//  University.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

public struct University: Codable {
    public let name: String
    public let stateProvince: String?
    public let domains: [String]
    public let webPages: [String]
    public let country: String
    public let alphaTwoCode: String

    public enum CodingKeys: String, CodingKey {
        case name
        case stateProvince = "state-province"
        case domains
        case webPages = "web_pages"
        case country
        case alphaTwoCode = "alpha_two_code"
    }

    enum JSONBody: String {
        case name = "name"
        case stateProvince = "state-province"
        case domains = "domains"
        case webPages = "web_pages"
        case country = "country"
        case alphaTwoCode = "alpha_two_code"
    }

    var payloadDic: [String: Any] {
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
