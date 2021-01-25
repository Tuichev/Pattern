//
//  ApiSettings.swift
//

import Foundation

enum Environment {
    case dev
    case production
    
    var baseUrl: String {
        switch self {
        case .dev: return ""
        case .production: return ""
        }
    }
}

class ApiSettings {
    private let currentEnviroment: Environment = .production //.production
  
        
    var serverBaseURL: String {
        return currentEnviroment.baseUrl
    }
    
    init() {}
    
    func removeObject(key: String) {
        currentDefaults.removeObject(forKey: key)
    }
    
    var token: String? {
        return ProfileStorage.token
    }
}
