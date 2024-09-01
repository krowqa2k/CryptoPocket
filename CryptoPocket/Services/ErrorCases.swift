//
//  ErrorCases.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import Foundation

enum ErrorCases: LocalizedError {
    case InvalidURL
    case InvalidResponse
    case InvalidData
    
    var errorDescription: String? {
        switch self {
        case .InvalidURL: return "Invalid URL found"
        case .InvalidResponse: return "Invalid URL response"
        case .InvalidData: return "Invalid Data found"
        }
    }
}
