//
//  BaseViewModel.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import RxSwift

public protocol ViewModel {
	associatedtype Input
	associatedtype Output

	func transform(_ input: Input, disposeBag: DisposeBag) -> Output
}
