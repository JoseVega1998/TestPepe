//
//  ButtonModel.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import UIKit

public struct ButtonModel {
    var baseFont: UIFont = UIFont.bodyFont(type: .Medium)
    var withBorder: Bool = false
    var withUnderline: Bool = false
    var cornerRadius: CGFloat = 0
    var title: String = ""
    let colorSet: ButtonColorSet
}
