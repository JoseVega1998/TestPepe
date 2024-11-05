//
//  Encodale+Dictionary.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 04/11/24.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments)
        ).flatMap { $0 as? [String: Any] }
    }
}
