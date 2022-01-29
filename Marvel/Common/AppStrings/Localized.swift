//
//  Localized.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import Foundation

extension String {
    
    /**
     Gets the localized string from the specified strings file using the receiver as the key
     
     - parameter fileName: .strings file that contains the key
     */
    public func localized(usingFile fileName: String) -> String {
        
        return localized(usingFile: fileName, withComment: "")
    }
    
    
    /**
     Gets the localized string from the specified strings file using the receiver as the key
     - parameter fileName: .strings file that contains the key
     - parameter BundleLanguage: the base language raw value of the enum BaseLanguage
     - parameter withComment: comment
     */
    public func localized(usingFile fileName: String, bundleLanguage: String? = nil, withComment comment: String) -> String {
        
        if let bundleLanguage = bundleLanguage,
            let path = Bundle.main.path(forResource: bundleLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            
            return NSLocalizedString(self, tableName: fileName, bundle: bundle, value: "", comment: comment)
            
        } else {
            return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: "", comment: comment)
        }
    }
}
