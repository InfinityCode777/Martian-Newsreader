//
//  SupportLanguage.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import Foundation

enum SupportLanguage: String, CaseIterable, CustomStringConvertible {
    case en
    case mr
    
    var description: String {
        switch self {
        case .en:
            return "English"
        case .mr:
            return "Martian"
        }
    }
}
