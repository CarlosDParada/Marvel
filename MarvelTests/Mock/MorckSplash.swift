//
//  MorckSplash.swift
//  MarvelTests
//
//  Created by Carlos Parada on 1/02/22.
//

import Foundation
import RxCocoa
@testable import Marvel


class TestSplashManager: ISplashManager {
    
    var errorMessage = PublishRelay<String>()
    
    func checkAPIState(response: @escaping SuccessCheckAPICallback) {
        let checkAPI = TestApiRequest(resource: CharactersListResource(limit: 1, offset:0))
        
        checkAPI.load { result in
            switch result {
            case .success(let data):
                response(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage.accept(error.localizedDescription)
                }
            }
        }
    }
    
    
}

class TestSplashPresenter: ISplashPresenter {
    var legalString: String?
    func loadData(legal: String) {
        legalString = legal
    }
    
    func showActivityIndicator(state: Bool) {
        print(">> Test ShowLoading \(state)")
    }
    
}

class TestSplashInteractor: ISplashInteractor {
    
    var dataLegal : String = ""
    var errorMessageInt: PublishRelay<String>
    
    init(data : String = "") {
        self.dataLegal = data
        self.errorMessageInt = PublishRelay<String>()
    }
    
    func initSplash() {
        self.errorMessageInt.accept("Data provided by Marvel. © 2019 MARVEL")
    }
    
}
