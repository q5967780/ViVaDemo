//
//  ModelAppUtils.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import Foundation
import UIKit

public class ModelAppUtils: NSObject {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    
    public static func hexStringToUIColor (hex:String) -> UIColor {
        if hex.count == 0 { return hexStringToUIColorByAlpha(hex: "#000000", setAlpha: 1.0) }
        var hexReg = hex
        if hexReg.contains("0x") {
            hexReg = hexReg.replace(target: "0x", withString: "#")
        }
        return hexStringToUIColorByAlpha (hex: hexReg, setAlpha: 1.0)
    }
    
    public static func getResize( size:CGFloat ) -> CGFloat {
        let screenSize = UIScreen.main.bounds.size
        return screenSize.width * size / 414.0
    }
    
    static func hexStringToUIColorByAlpha (hex:String, setAlpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
    }
        
        if ((cString.count) != 6) {
            return hexStringToUIColorByAlpha(hex: "#000000", setAlpha: 1.0)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(setAlpha)
        )
    }
    
    static func openLink(_ urlString: String) {
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("無法開啟網址")
            }
        } else {
            print("無效的網址:",urlString)
        }
    }
}

extension String{
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
