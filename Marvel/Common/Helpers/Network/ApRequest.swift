//
//  ApRequest.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

class ApiRequest<Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension ApiRequest: NetworkRequest {
    func decode(_ data: Data) throws -> Resource.ModelType {
        let jsonDecoder = JSONDecoder()
        do {
            let object = try jsonDecoder.decode(Resource.ModelType.self, from: data)
            return object
        } catch let DecodingError.dataCorrupted(context) {
            print("Context dataCorrupted:", context.debugDescription)
//            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        let object = try jsonDecoder.decode(Resource.ModelType.self, from: data)
        return object
    }
    
    func load(completion: @escaping (Result<Resource.ModelType, Error>) -> Void) {
        load(url: resource.url, completion: completion)
    }
}
