//
//  EncodableExtension.swift
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func queryItems() -> String {
        guard let dic = dictionary else { return "" }
        
        var components = URLComponents()
        components.queryItems = dic.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }
        
        let customAllowedSet = CharacterSet.init(charactersIn: "_+-").inverted
        return components.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? ""
    }
    
}
