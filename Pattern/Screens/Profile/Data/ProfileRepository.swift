//
//  ProfileRepository.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation

//look at #3 Repository in Comments file
protocol ProfileRepositoryProtocol: ProfileRequestsProtocol {
}

class ProfileRepository: ProfileRepositoryProtocol {
    let profileApi = ProfileRequests()
    
    func getProfile(resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void) {
        profileApi.getProfile(resp: resp)
    }
    
    func updateProfile(data: ProfileNetworkEntity, resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void) {
        profileApi.updateProfile(data: data, resp: resp)
    }
}
