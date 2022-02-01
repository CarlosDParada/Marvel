//
//  MockRequest.swift
//  MarvelTests
//
//  Created by Carlos Parada on 1/02/22.
//

import Foundation
import RxCocoa
@testable import Marvel

class TestApiRequest<Resource: ApiResource> : NetworkRequest {
   
    typealias ModelType = Resource.ModelType
    
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
    
    func decode(_ data: Data) throws -> Resource.ModelType {
        let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(Resource.ModelType.self, from: data)
        return object
    }
    
    func load(completion: @escaping (Result<Resource.ModelType, Error>) -> Void) {
        
        let filename: String = "PrincipalResponseWrapper"
        let typeFile = Resource.ModelType.self
            print(">> typeFile = \(typeFile)")
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return
        }
        do {
            let object = try self.decode(data)
            completion(.success(object))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    func load(file: Resource.ModelType,
              completion: @escaping (Result<Resource.ModelType, Error>) -> Void) {
        let typeFile = file
        print(">> typeFile = \(typeFile)")
    }
}
