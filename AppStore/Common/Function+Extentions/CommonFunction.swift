//
//  CommonFunction.swift
//  AppStore
//
//  Created by 60067669 on 6/24/21.
//

import RxSwift

// MARK: - Common Function

/// URL 이미지 다운로드 함수
/// - Parameter url: 다운로드할 이미지 URL
func loadImage(url: URL) -> Observable<UIImage?> {
	return Observable<UIImage?>.create { emitter in
		let task = URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data else {
				emitter.onNext(nil)
				emitter.onCompleted()
				return
			}
			let image = UIImage(data: data)
			emitter.onNext(image)
			emitter.onCompleted()
		}
		task.resume()
		return Disposables.create {
			task.cancel()
		}
	}
}

/// getViewController with storyboard
/// - Parameter storyboardName: storyboard 이름
/// - Parameter identifier: identifier
func getViewController(storyboardName: String, identifier: String) -> UIViewController? {
	let storyBoard: UIStoryboard! = UIStoryboard(name: storyboardName, bundle: nil)
	return storyBoard.instantiateViewController(withIdentifier: identifier)
}
