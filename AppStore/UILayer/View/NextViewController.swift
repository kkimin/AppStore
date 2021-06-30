//
//  NextViewController.swift
//  AppStore
//
//  Created by 기민주 on 2021/06/23.
//

import UIKit

final class NextViewController: BaseViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		go()
	}

	private func go() {
		if let viewController = getViewController(storyboardName: "Main", identifier: "MainView") as? MainViewController {
			navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

protocol Navigator {
	func goDetail(_ app: AppModel)
}

protocol LinkTransferMemoListDataPassing {
	var dataStore: LinkTransferMemoListDataStore? { get }
}

protocol LinkTransferMemoListDataStore {
	var memoType: String { get set } // usecase로 변경해야되는것같다.
}

class AppStoreNavigator: Navigator, LinkTransferMemoListDataPassing {
	//private let storyBoard: UIStoryboard
	//private let navigationController: UINavigationController
	weak var viewController: UIViewController?
	var dataStore: LinkTransferMemoListDataStore?

	//init(navigationController: UINavigationController) {
		//self.navigationController = navigationController
		//self.storyBoard = storyBoard
	//}

	func goDetail(_ app: AppModel) {
		if let nextViewController = getViewController(storyboardName: "Main", identifier: "AppDetailView") as? AppDetailViewController {
			viewController?.navigationController?.pushViewController(nextViewController, animated: true)
		}
	}

}
