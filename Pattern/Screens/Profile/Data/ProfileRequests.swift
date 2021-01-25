//
//  ProfileRequests.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation
import Alamofire

protocol ProfileRequestsProtocol {
    func getProfile(resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void)
    func updateProfile(data: ProfileNetworkEntity, resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void)
}

class ProfileRequests: RestClient, ProfileRequestsProtocol {
    
    enum EndPoints: String {
        case getProfile = "profile"
    }
    
    func getProfile(resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void) {
        let url = baseUrl + EndPoints.getProfile.rawValue
        
        http.queryBy(url, method: .get, encoding: JSONEncoding.default, queue: .defaultQos, resp: { [weak self] result in
  
            self?.response(result: result, modelCls: ProfileNetworkEntity.self, resp: resp)
        })
    }
    
    func updateProfile(data: ProfileNetworkEntity, resp: @escaping (Result<ProfileNetworkEntity, CustomError>) -> Void) {
        let url = baseUrl + EndPoints.getProfile.rawValue
        let params = data.dictionary ?? [:]
        
        http.queryBy(url, method: .post, parameters: params, encoding: JSONEncoding.default, queue: .defaultQos, resp: { [weak self] result in
  
            self?.response(result: result, modelCls: ProfileNetworkEntity.self, resp: resp)
        })
    }
}
