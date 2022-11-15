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
    case invalidUrl
    case emptyModel
    case invalidUrlResponse
    case invalidData
    case statusCodeNot200
    case failedToGetSelf
    case genericError(Error?)
    case testError
    
    public var errorDescription: String? {
        switch self {
        case .failedToDecodeJson:
            return "Failed to decode the json"
        case .failedToLocateFile:
            return "Failed to locate file"
        case .emptyModel:
            return "Empty domain model"
        case .invalidUrlResponse:
            return "Invalid URL Response"
        case .invalidData:
            return "Invalid data"
        case .statusCodeNot200:
            return "Status code is not 200"
        case .failedToGetSelf:
            return "Failed to get self"
        default:
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
