//
//  MainViewController.swift
//  AppStore
//
//  Created by 기민주 on 2021/06/19.
//

import UIKit
import RxSwift
import RxCocoa
import Then

final class MainViewController: BaseViewController {

	// MARK: - IBOutlets
	@IBOutlet weak var tableView: AppTableView!
	@IBOutlet weak var searchBar: UISearchBar!

	// MARK: - Properties
	private var viewModel: AppListViewModel! {
		didSet {
			bintInput()
		}
	}
	private var disposeBag = DisposeBag()
	var router: Navigator?

	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		bindView()
	}

	private func bindView() {
		tableView.do {
			$0.register(cellType: AppDetailCell.self)
			$0.delegate = self
			$0.estimatedRowHeight = 330
			$0.rowHeight = UITableView.automaticDimension
		}
		setupSearchBar()
		let router = AppStoreNavigator()
		router.viewController = self
		viewModel = AppListViewModel(useCase: SearchUseCase(input: ""), navigator: router)
	}

	// UISearchBar 초기 세팅
	private func setupSearchBar() {
		searchBar.do {
			$0.delegate = self
			$0.placeholder = "입력하세요"
		}
	}

	private func bintInput() {
		let input = AppListViewModel.Input(
			load: Driver.just(()),
			searchText: searchBar.rx.text.orEmpty.asDriver(),
			selectApp: tableView.rx.itemSelected.asDriver()
		)

		let output = viewModel.transform(input, disposeBag: disposeBag)

			output.appList
			.asDriver(onErrorDriveWith: .empty())
			.drive(tableView.rx.items) { tableView, index, app in
				return tableView.dequeueReusableCell(
					for: IndexPath(row: index, section: 0),
					cellType: AppDetailCell.self)
					.then {
						$0.bindViewModel(app)
					}
			}
			.disposed(by: disposeBag)

		output.selectApp
			.drive()
			.disposed(by: disposeBag)
	}

	@IBAction func onClickPop(_ sender: Any) {
		self.navigationController?.popViewController(animated: true)
	}
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("didselect")
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
