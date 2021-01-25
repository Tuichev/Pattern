//
//  ProfileStorage.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation

class ProfileStorage {
    private static var currentDefaults: UserDefaults = .standard
    
    static var token: String? {
        
        set {
            currentDefaults.set(newValue, forKey: StorageKeys.token.rawValue)
        }
        
        get {
            guard let value = currentDefaults.object(forKey: StorageKeys.token.rawValue) as? String else {
                return nil
            }
            
            return !value.isEmpty ? value : nil
        }
    }
}
