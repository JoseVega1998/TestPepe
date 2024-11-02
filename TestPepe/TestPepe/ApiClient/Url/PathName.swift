//
//  PathName.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 01/11/24.
//

import Foundation

enum PathName: String {
    case movie = "/movie"
    
    static func getPathName(with endpoint: Endpoint) -> PathName {
        switch endpoint {
        case .topRated: return .movie
        }
    }
}
