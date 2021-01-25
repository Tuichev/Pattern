//
//  ProfileNetworkEntity.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation

struct ProfileNetworkEntity: Codable {
    var name: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "_name"
    }
    
    init(name: Int? = nil) {
        self.name = name
    }
}
