//
//  BaseViewController.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import UIKit

protocol BaseViewDelegate: AnyObject {
	// var naviType: NavigationType { get set }
}

class BaseViewController: UIViewController, BaseViewDelegate {
	// MARK: - 변수 선언
	deinit {
		print(String(describing: type(of: self)) + " deinit")
	}
}

// MARK: - BaseViewController UISearchBarDelegate

extension BaseViewController: UISearchBarDelegate {
	// 검색 버튼 클릭
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.resignFirstResponder()
	}
}

// MARK: - BaseViewController UIScrollViewDelegate

extension BaseViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		self.view.endEditing(true)
	}
}
