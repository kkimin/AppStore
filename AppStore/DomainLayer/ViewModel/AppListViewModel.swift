//
//  AppListViewModel.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import RxSwift
import RxCocoa

// MARK: - AppListViewModel

final class AppListViewModel: ViewModel {
	private let useCase: AppListUseCase
	private let navigator: Navigator

	init(useCase: AppListUseCase, navigator: Navigator) {
		self.useCase = useCase
		self.navigator = navigator
	}

	deinit {
		print(String(describing: type(of: self)) + " deinit")
	}

	struct Input {
		let load: Driver<Void>
		let searchText: Driver<String> // search bar input Text
		let selectApp: Driver<IndexPath>
	}

	struct Output {
		var error: Error?
		var appList: Driver<[AppModel]>
		var isEmpty = false
		let selectApp: Driver<AppModel>
	}

	func transform(_ input: Input, disposeBag: DisposeBag) -> Output {
		let searchList = input.searchText
			.debounce(.milliseconds(300)) // 0.3 seconds
			.distinctUntilChanged()
			.flatMapLatest { text in
			return self.useCase.search(input: text)
				.asDriverOnErrorJustComplete()
		}
		let nextAppDetail = input.selectApp
			.withLatestFrom(searchList) { (indexPath, searchList) -> AppModel in
				print(indexPath.row)
				return searchList[indexPath.row]
			}
			.do(onNext: navigator.goDetail) { (model) in
				print(model)
			}
		return Output(error: nil, appList: searchList, isEmpty: false, selectApp: nextAppDetail)
	}
}
