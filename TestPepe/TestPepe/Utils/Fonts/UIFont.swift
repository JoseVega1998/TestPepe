//
//  UIFont.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit
import CoreGraphics
import CoreText

extension UIFont {            
    //MARK: - Title
    public static func titleXxlFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.titleXxl) ?? .systemFont(ofSize: FontSizes.titleXxl)
    }
    
    public static func titleXlFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.titleXl) ?? .systemFont(ofSize: FontSizes.titleXl)
    }
    
    public static func titleLFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.titleL) ?? .systemFont(ofSize: FontSizes.titleL)
    }
    
    public static func titleFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.title) ?? .systemFont(ofSize: FontSizes.title)
    }
    
    //MARK: - Body
    public static func bodyXxlFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.bodyXxl) ?? .systemFont(ofSize: FontSizes.bodyXxl)
    }
    
    public static func bodyXlFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.bodyXl) ?? .systemFont(ofSize: FontSizes.bodyXl)
    }
    
    public static func bodyLFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.bodyL) ?? .systemFont(ofSize: FontSizes.bodyL)
    }
    
    public static func bodyFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.body) ?? .systemFont(ofSize: FontSizes.body)
    }
    
    public static func bodySFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.bodyS) ?? .systemFont(ofSize: FontSizes.bodyS)
    }
    
    public static func bodyXsFont(font: Font = .Montserrat, type: FontType) -> UIFont {
        UIFont(name: font.rawValue + type.rawValue, size: FontSizes.bodyXs) ?? .systemFont(ofSize: FontSizes.bodyXs)
    }
}
