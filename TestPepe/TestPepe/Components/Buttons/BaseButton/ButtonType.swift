//
//  ButtonType.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import Foundation

@objc public enum BaseButtonType: Int {
    case Primary
    case Secondary
    case Text
    
    var model: ButtonModel {
        let constants = ButtonsConstants()
        switch self {
        case .Primary: return constants.primaryButtonModel
        case .Secondary: return constants.secondaryButtonModel
        case .Text: return constants.textButtonModel
        }
    }
}
