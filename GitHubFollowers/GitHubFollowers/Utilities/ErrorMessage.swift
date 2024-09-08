//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 9/8/24.
//

import Foundation

enum ErrorMessage: String {
    case invalidUseername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data recived from the server was invalid. Please try again."
}
