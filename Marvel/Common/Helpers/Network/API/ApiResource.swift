//
//  ApiResource.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

protocol ApiResource {
    associatedtype ModelType: Decodable
    var endpoint: String { get }
    var parameters: [String: String] { get }
    var url: URL { get }
}

extension ApiResource {
    var url: URL {
        guard let baseUrl = Configuration.shared.getValueConfiguration(
                withType: String.self, key: .baseUrl)else {
            fatalError("Invalid String base URL")
        }
        guard var urlComponents = URLComponents(string: baseUrl) else {
            fatalError("Invalid base URL")
        }

        urlComponents.path += endpoint

        urlComponents.queryItems = []
        // Secure API KEY
        urlComponents.queryItems?.append(URLQueryItem(name: ConfigurationKey.ts.rawValue,
                                            value: Configuration.shared.getValueConfiguration(withType: String.self, key: .ts)))
        urlComponents.queryItems?.append(URLQueryItem(name: ConfigurationKey.apikey.rawValue ,
                                                      value: Configuration.shared.getValueConfiguration(withType: String.self, key: .apikey)))
        urlComponents.queryItems?.append(URLQueryItem(name: ConfigurationKey.hash.rawValue,
                                                      value: Configuration.shared.getValueConfiguration(withType: String.self, key: .hash)))
        for parameter in parameters {
            urlComponents.queryItems?.append(URLQueryItem(name: parameter.key, value: parameter.value))
        }

        guard let url = urlComponents.url else {
            fatalError("Cannot get url from url components")
        }

        return url
    }

    var endpoint: String { "" }
    var parameters: [String: String] { [:] }
}
