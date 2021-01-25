//
//  InternetService.swift
//

import Foundation
import Alamofire

typealias IdResponseBlock = (Result<Data, CustomError>) -> Void

enum QueueQos {
    case background
    case defaultQos
}

protocol CustomErrorProtocol: Error {
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    var localizedDescription: String
    var code: Int
    
    init(localizedDescription: String, code: Int) {
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class HttpService {
    
    private let userDefaults = UserDefaultsManager()
    private static let queueQos: DispatchQueue = DispatchQueue(label: "com.lampa-queueDefault", qos: .default, attributes: [.concurrent])
    
    func checkInternetConnect() -> Bool {
        return InternetService.shared.checkInternetConnect()
    }
    
    func internetConnectErr() -> CustomError {
        return CustomError(localizedDescription: StringValue.Base.kNoInternetConnection.localized, code: 404)
    }
}

extension HttpService {
    
    func cancellAllRequests() {
        Alamofire.Session.default.cancelAllRequests()
    }
    
    func queryBy(_ url: URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 queue: QueueQos,
                 headers: HTTPHeaders? = nil,
                 resp: @escaping IdResponseBlock) {
        
        let tokenValue = userDefaults.token ?? "MHGxDqa2VzhX2d4KPkYdZrAKBAeADxGr"
        
        var headersForQuery: HTTPHeaders = headers ?? [:]
        
        if !tokenValue.isEmpty {
            headersForQuery[Keys.autorithationToken] = tokenValue
        }
        
        headersForQuery[Keys.appVersion] = 1.0.description
        headersForQuery[Keys.language] = "uk"
        
        return query(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: headersForQuery,
                     queue: queue,
                     resp: resp)
    }
    
    func queryWithoutTokenBy(_ url: URLConvertible,
                             method: HTTPMethod = .get,
                             parameters: Parameters? = nil,
                             encoding: ParameterEncoding = URLEncoding.default,
                             headers: HTTPHeaders? = nil,
                             queue: QueueQos,
                             resp:@escaping IdResponseBlock) {
        
        query(url,
              method: method,
              parameters: parameters,
              encoding: encoding,
              headers: headers,
              queue: queue,
              resp: resp)
        
    }
    
    func query(_ url: URLConvertible,
               method: HTTPMethod = .get,
               parameters: Parameters? = nil,
               encoding: ParameterEncoding = URLEncoding.default,
               headers: HTTPHeaders? = nil,
               queue: QueueQos,
               resp: @escaping IdResponseBlock) {
        
        
        
        if !checkInternetConnect() {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            return resp(.failure(internetConnectErr()))
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers
        ).validate().responseData(queue: HttpService.queueQos) { [weak self] (response) in
            self?.parseResponse(response, respCompletion: resp)
        }
    }
    
    func queryMultipart(_ url: URLConvertible,
                        method: HTTPMethod = .post,
                        parameters: Parameters? = nil,
                        data: Data? = nil,
                        fileName: String? = nil,
                        image: [UIImage]? = nil,
                        keyForFile: String = "file",
                        headers: HTTPHeaders? = nil,
                        encoding: ParameterEncoding = URLEncoding.default,
                        resp: @escaping IdResponseBlock) {
        
        if !checkInternetConnect() {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            return resp(.failure(internetConnectErr()))
        }
        
        let tokenValue = userDefaults.token ?? "MHGxDqa2VzhX2d4KPkYdZrAKBAeADxGr"
        let token = BaseRequests.prefix + tokenValue
        
        var headersForQuery: HTTPHeaders = headers ?? [:]
        
        if !tokenValue.isEmpty {
            headersForQuery[Keys.autorithationToken] = token
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            if let params = parameters {
                for (key, value) in params {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            
            if let data = data {
                guard let fName = fileName else { return }
                
                multipartFormData.append(data, withName: fName, fileName: keyForFile, mimeType: "application")
            }
            
            if let data = image {
                
                for item in data {
                    
                    guard let fName = fileName else { return }
                    
                    if let imageData = item.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: keyForFile, fileName: fName, mimeType: "image/jpeg")
                    }
                }
            }
            
        }, to: url, method: method, headers: headersForQuery).validate().responseData { [weak self] (response) in
            self?.parseResponse(response, respCompletion: resp)
        }
    }
    
    private func parseResponse(_ response: AFDataResponse<Data>,  respCompletion: @escaping IdResponseBlock) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        
        let statusCode = response.response?.statusCode ?? 0
        
        if statusCode == 403 {
            DispatchQueue.main.async {
                self.logout()
            }
        }
        switch response.result {
        case .success(let value):
            return respCompletion(.success(value))
        case .failure(let error):
            let customError = CustomError(localizedDescription: error.localizedDescription, code: statusCode)
            respCompletion(.failure(customError))
        }
    }
    
    func logout() {
        // If the application is opened by pressing on push notification, you do not need to change the main controller
        let navigationController = UINavigationController()
        let authorizationVC = LoginViewController.instance(.authorization)
        navigationController.navigationBar.isHidden = true
        navigationController.interactivePopGestureRecognizer?.isEnabled = false //disable back swipe
        navigationController.viewControllers = [authorizationVC]
        UserDefaultsManager().isUserLoggedIn = false
        
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
}

