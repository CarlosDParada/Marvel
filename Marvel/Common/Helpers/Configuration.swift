//
//  Configuration.swift
//  Marvel
//
//  Created by Carlos Parada on 26/01/22.
//

import Foundation

enum ConfigurationKey: String {
    case baseUrl = "BASE_URL"
    case publicKeySign = "PUBLIC_KEY_SIGN"
    case ts = "ts"
    case apikey = "apikey"
    case hash = "hash"
}

class Configuration {
    static let shared = Configuration()
    
    func getValueConfiguration<T> (withType _:T.Type, key:ConfigurationKey) -> T? {
        
        if let configurations = getConfigurations() {
            return configurations.object(forKey: key.rawValue) as? T
        }
        return nil
    }
    
    private func getConfigurations () -> NSDictionary? {
        var bundle = Bundle.main
        if bundle.bundleURL.pathExtension == "appex" {
            bundle = (Bundle(url: bundle.bundleURL.deletingLastPathComponent())) ?? bundle
        }
        let envsPListPath = bundle.path(forResource: MarvelConstants.Configuration.configurations, ofType: ".plist")
        guard let passEncryptedData = try? NSData(contentsOfFile: envsPListPath ?? "") as Data else {
            return nil
        }
        do {
          
            if let enviroments = try PropertyListSerialization.propertyList(from: passEncryptedData,
                                                                            options: .mutableContainersAndLeaves,
                                                                            format: nil) as? [String:Any] {
                let obj = enviroments[getEnvironment()]
                return obj as? NSDictionary
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
     private func getEnvironment() -> String {
        let dictionary: NSDictionary = Bundle.main.infoDictionary! as NSDictionary
        let env: String? = dictionary.object(forKey: MarvelConstants.Configuration.configuration) as? String
        return env ?? ""
    }
    
}
