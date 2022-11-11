//
//  ErrorEnums.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/11/22.
//

import Foundation

public enum DataFetchError: LocalizedError {
    case failedToDecodeJson
    case failedToLocateFile
    case testError
    
    public var errorDescription: String? {
        switch self {
        case .failedToDecodeJson:
            return "Failed to decode the json"
        case .failedToLocateFile:
            return "Failed to locate file"
        case .testError:
            return ""
        }
    }
}


public enum GenericError: LocalizedError {
    case failedToGetSelf
    
    public var errorDescription: String? {
        switch self {
        case .failedToGetSelf:
            return "Failed to get self in guard closure"
        }
    }
}
