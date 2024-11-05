//
//  ButtonConstants.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 02/11/24.
//

import Foundation

struct ButtonsConstants {
    struct ViewModifiers {
        static let maxLinesNumber: Int = 1
        static let borderWidth: CGFloat = 1
        static let height: CGFloat = 50
        static let contentInsetLateral: CGFloat = 60
    }
    
    let primaryButtonModel: ButtonModel = ButtonModel(
        baseFont: .bodyFont(type: .Bold),
        withBorder: false,
        cornerRadius: 25,
        colorSet: ButtonColorSet(
            foregroundColor: .white,
            backgroundColor: .primary,
            disableForegroundColor: .white,
            disableBackgroundColor: .third,
            highlightedForegroundColor: .primaryLight,
            highlightedBackGroundColor: .clear
        )
    )
    
    let secondaryButtonModel: ButtonModel = ButtonModel(
        baseFont: .bodyFont(type: .Bold),
        withBorder: false,
        cornerRadius: 25,
        colorSet: ButtonColorSet(
            foregroundColor: .white,
            backgroundColor: .secondary,
            disableForegroundColor: .white,
            disableBackgroundColor: .third,
            highlightedForegroundColor: .secondaryLight,
            highlightedBackGroundColor: .clear
        )
    )
    let textButtonModel: ButtonModel = ButtonModel(
        baseFont: .bodyFont(type: .Bold),
        withBorder: false,
        withUnderline: true,
        colorSet: ButtonColorSet(
            foregroundColor: .primary,
            backgroundColor: .clear,
            disableForegroundColor: .third,
            disableBackgroundColor: .clear,
            highlightedForegroundColor: .primary,
            highlightedBackGroundColor: .clear
        )
    )

}
