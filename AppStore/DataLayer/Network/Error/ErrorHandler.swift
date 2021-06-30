//
//  ErrorHandler.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import Foundation
import RxSwift
import RxCocoa

class ErrorHandlers: SharedSequenceConvertibleType {
	public typealias SharingStrategy = DriverSharingStrategy
	private let _subject = PublishSubject<Error>()

	public init() {
	}

	open func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
		return source.asObservable().do(onError: onError)
	}

	open func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
		return _subject.asObservable().asDriverOnErrorJustComplete()
	}

	open func asObservable() -> Observable<Error> {
		return _subject.asObservable()
	}

	private func onError(_ error: Error) {
		_subject.onNext(error)
	}

	deinit {
		_subject.onCompleted()
	}
}

extension ObservableConvertibleType {
	func trackError(_ errorTracker: ErrorHandlers) -> Observable<Element> {
		return errorTracker.trackError(from: self)
	}
}

extension ObservableType {

	func catchErrorJustComplete() -> Observable<Element> {
		return `catch` { _ in
			return Observable.empty()
		}
	}

	public func asDriverOnErrorJustComplete() -> Driver<Element> {
		return asDriver { _ in
			return Driver.empty()
		}
	}

	public func mapToVoid() -> Observable<Void> {
		return map { _ in }
	}

	public func mapToOptional() -> Observable<Element?> {
		return map { value -> Element? in value }
	}

	public func unwrap<T>() -> Observable<T> where Element == T? {
		return flatMap { Observable.from(optional: $0) }
	}
}
