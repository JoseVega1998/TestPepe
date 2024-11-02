//
//  BaseUrl.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 01/11/24.
//

import Foundation

struct BaseUrl {
    static func getBaseUrl() -> String {
        do {
            // get from configuration file
            let url: String = "https://api.themoviedb.org/3"
            return url
        }
        catch {
            fatalError("review configuration variables")
        }
    }
    
    static func getUrl(with endpoint: Endpoint) -> String {
        let url = self.getBaseUrl()
        return url + PathName.getPathName(with: endpoint).rawValue + endpoint.rawValue
    }
}
