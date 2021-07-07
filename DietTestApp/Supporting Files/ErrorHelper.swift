//
//  ErrorHelper.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation

/**
 Singleton that helps you to create NSError.
 
 Usage example:
 
     let error = ErrorHelper.shared.error(NSLocalizedString("Unauthorized", comment: "Account not activated"))
 
 */

class ErrorHelper {
    
    static let shared = ErrorHelper()
    private init() {}
    
    private let errorDomain = "\(String(describing: Bundle.main.bundleIdentifier)).error"
    private let errorFuncKey = "\(String(describing: Bundle.main.bundleIdentifier)).function"
    private let errorFileKey = "\(String(describing: Bundle.main.bundleIdentifier)).file"
    private let errorLineKey = "\(String(describing: Bundle.main.bundleIdentifier)).line"
    
    /**
     With this function you create NSError.
     
     Usage:
     
         let error = ErrorHelper.shared.error("Can't download video", "Can't download video".localized)

     - Parameters:
         - message: Error NSDebugDescriptionErrorKeyString
         - localizedMessage: Error NSLocalizedDescriptionKey
         - record: Bool value. Set true if you want to record this error to Crashlitycs. Default is false
         - function: Private parameter to include errorFuncKey in error.
         - file: Private parameter to include errorFileKey in error.
         - line: Private parameter to include errorLineKey in error.

     - Returns:
         Configured NSError.
     
     */
    @discardableResult
    func error(_ message: String, _ localizedMessage: String? = nil, record: Bool = false, function: String = #function, file: String = #file, line: Int = #line) -> NSError {
        
        let customError = NSError(domain: errorDomain, code: 0, userInfo: [
            NSDebugDescriptionErrorKey: message,
            NSLocalizedDescriptionKey: localizedMessage ?? message,
            errorFuncKey: function,
            errorFileKey: file,
            errorLineKey: line
            ])
        
        if (record) {
            customError.record()
        }
        
        return customError
    }
}

private extension NSError {
    
    func record() {
//        Crashlytics.crashlytics().record(error: self)
    }
    
}
