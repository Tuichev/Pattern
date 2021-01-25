//
//  RestClient.swift
//

class RestClient: NSObject {
    
    let http = HttpService()
    let baseUrl = BaseRequests.baseURL
    
    func response<P: Codable>(result: Result<Data, CustomError>, modelCls: P.Type, resp: @escaping (Result<P, CustomError>) -> Void) {
        
        switch result {
        case .success(let data):
            do {
                let model = try JSONDecoder().decode(modelCls.self, from: data)
                return resp(.success(model))
            } catch let error {
                let parsingError = CustomError.init(localizedDescription: error.localizedDescription, code: 0)
                return resp(.failure(parsingError))
            }
 
        case .failure(let error):
            return resp(.failure(error))
        }
    }
    
    func cancellRequests() {
        http.cancellAllRequests()
    }
}
