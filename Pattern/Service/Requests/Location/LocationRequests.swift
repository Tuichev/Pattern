//
//  HomeRequests.swift
//

import Foundation

class LocationRequests: RestClient {
    
    func getCitiesList(resp: @escaping (Result<ListResponse<City>, CustomError>) -> Void) {
        
        let url = baseUrl + Requests.Location.update
        
        http.queryBy(url, method: .get, encoding: JSONEncoding.default, queue: .defaultQos, resp: { [weak self] result in
  
            self?.response(result: result, modelCls: ListResponse<City>.self, resp: resp)
        })
    }
}
