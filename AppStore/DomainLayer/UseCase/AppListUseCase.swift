//
//  AppListUseCase.swift
//  AppStore
//
//  Created by 60067669 on 6/23/21.
//

import RxSwift
import RxAlamofire

protocol AppListUseCase {
	/// applist Search
	func search(input: String) -> Observable<[AppModel]>
}

final class SearchUseCase: AppListUseCase {
	private var request: String = ""

	init(input: String) {
		request = input
	}

	func search(input: String) -> Observable<[AppModel]> {
		print(input)
		let resultData = RxAlamofire.requestData(.get,
												 NetworkConstants.ROOTPATH+"/search", parameters: ["term": input, "country": "KR", "media": "software", "entity": "software"])
			.map({ (data) -> Any in
				return data
			})
			.mapObject(type: InquiryModel.self)
			.map { $0.list }
		return resultData
	}

	enum NetworkConstants {
		static let NETWORK_TIMEOUT_FOR_REQUEST = 60.0
		static let ROOTPATH = "https://itunes.apple.com"
	}
}
