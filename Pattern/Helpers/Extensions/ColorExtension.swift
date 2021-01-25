//
//  ColorExtension.swift
//

import UIKit

extension UIColor {
    
    enum AssetsColor: String {
        case black
        case darkIndigo
        case darkSlateBlue
        case greyBlue
        case lipstick
        case pumpkinOrange
        case tealish
        case white
    }
    
    static func appColor(_ name: AssetsColor) -> UIColor {
        let color = UIColor(named: name.rawValue)
        
        if color == nil {
            print("Error: color \(name.rawValue) not found")
        }
        
        return color ?? .black
    }
}
