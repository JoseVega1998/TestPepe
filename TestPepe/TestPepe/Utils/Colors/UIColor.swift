//
//  UIColor.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

extension UIColor {
    
    public enum Colors: String {
        case alert_light
        case alert
        case blackground_2
        case blackground
        case primary_light
        case primary
        case secondary_light
        case secondary
        case third_light
        case third
    }
    
    var alert: UIColor {
        UIColor(named: Colors.alert.rawValue) ?? .black
    }
    
    var alertLight: UIColor {
        UIColor(named: Colors.alert_light.rawValue) ?? .black
    }
    
    var blackgroundTwo: UIColor {
        UIColor(named: Colors.blackground_2.rawValue) ?? .black
    }

    var blackground: UIColor {
        UIColor(named: Colors.blackground.rawValue) ?? .black
    }

    var primaryLight: UIColor {
        UIColor(named: Colors.primary_light.rawValue) ?? .black
    }

    var primary: UIColor {
        UIColor(named: Colors.primary.rawValue) ?? .black
    }

    var secondaryLight: UIColor {
        UIColor(named: Colors.secondary_light.rawValue) ?? .black
    }

    var secondary: UIColor {
        UIColor(named: Colors.secondary.rawValue) ?? .black
    }

    var thirdLight: UIColor {
        UIColor(named: Colors.third_light.rawValue) ?? .black
    }

    var third: UIColor {
        UIColor(named: Colors.third.rawValue) ?? .black
    }
    
}
