//
//  ResponseData.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import Foundation

final class ResponseData {
	var statusCode: Int?
	var errorCode: NetworkError?
	var header: HTTPURLResponse?
	var body: Data?
	var URLLoadError: NSError?
	var errorDescription: String?  // error localizedDescription
}

public enum NetworkError: Swift.Error {
	case unknown
	case invalidSearchTerm
	case invalidURL
	case invalidConnection
	case serverError(Int)
	case urlLoadError(Int)
}
