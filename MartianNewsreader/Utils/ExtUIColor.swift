//
//  ExtUIColor.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = alpha
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
