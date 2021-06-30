//
//  ObservableType-Extenstions.swift
//  AppStore
//
//  Created by 기민주 on 6/23/21.
//

import RxSwift

extension ObservableType {
	public func mapObject<T: Codable>(type: T.Type) -> Observable<T> {
		return flatMap { data -> Observable<T> in
			let responseTuple = data as? (HTTPURLResponse, Data)

			guard let jsonData = responseTuple?.1 else {
				throw NSError(
					domain: "",
					code: -1,
					userInfo: [NSLocalizedDescriptionKey: "Could not decode object"]
				)
			}
			let decoder = JSONDecoder()
			do {
				let object = try decoder.decode(T.self, from: jsonData)
				print(jsonData.prettyPrintedJSONString)
				return Observable.just(object)
			} catch {
				print(error.localizedDescription)
				return Observable.empty() // error 처리 필요
			}
		}
	}
}
