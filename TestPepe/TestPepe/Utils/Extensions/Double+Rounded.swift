//
//  Double+Rounded.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 05/11/24.
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
