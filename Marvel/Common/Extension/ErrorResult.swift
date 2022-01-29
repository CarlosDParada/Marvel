//
//  ErrorResult.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

enum ErrorResult: Error {

    case network(string: String, code:Int)
    case parser(string: String, code:Int)
    case custom(string: String, code:Int)
}

extension ErrorResult {
    var localizedDescription: String {
        switch self {
        case .network(let message, _):   return message
        case .parser(let message, _):    return message
        case .custom(let message, _):    return message
        }
    }
    var code: Int? {
        switch self {
        case .network(_, let code):   return code
        case .parser(_, let code):   return code
        case .custom(_, let code):   return code
        }
    }
}
