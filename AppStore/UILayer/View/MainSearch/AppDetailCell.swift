//
//  AppDetailCell.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import UIKit
import RxSwift
import Reusable

final class AppDetailCell: UITableViewCell, NibReusable {
	@IBOutlet weak var appNameLabel: UILabel!
	@IBOutlet weak var appImageView: UIImageView!
	@IBOutlet weak var subTitleLabel: UILabel!
	@IBOutlet weak var starLabel: UILabel!
	@IBOutlet weak var openBtn: UIButton!
	@IBOutlet weak var stackView: UIStackView!
	private var imageViews: [UIImageView] = [UIImageView(), UIImageView(), UIImageView()]
	var disposeBag = DisposeBag()

	override func awakeFromNib() {
		super.awakeFromNib()
		initUI()
	}

	deinit {
		print("cell deinit")
	}

	private func initUI() {
		openBtn.roundCorners(.allCorners, radius: 10)
		imageViews.forEach { (imageView) in
			stackView.addArrangedSubview(imageView)
		}
	}

	func bindViewModel(_ viewModel: AppModel?) {
		if let viewModel = viewModel {
			appNameLabel.text = viewModel.trackName
			subTitleLabel.text = viewModel.collectionName
			starLabel.text = viewModel.releaseDate
			loadAppImage(urlString: viewModel.artworkUrl60)
			makeThreePreview(urlStrings: viewModel.screenshotUrls)
		}
	}

	/// load App Image
	private func loadAppImage(urlString: String) {
		loadImageWithItem(item: appImageView, urlString: urlString)
	}

	private func makeThreePreview(urlStrings: [String]) {
		for i in 0...2 where urlStrings.count > 2 && imageViews.count > 2 {
			loadImageWithItem(item: imageViews[i], urlString: urlStrings[i])
		}
	}

	private func loadImageWithItem(item: UIImageView, urlString: String) {
		let cacheKey = NSString(string: urlString) // 캐시에 사용될 Key 값
		if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
			DispatchQueue.main.async {
				item.image = cachedImage
			}
		} else if let url = URL.init(string: urlString) {
			loadImage(url: url)
				.observe(on: MainScheduler.instance)
				.compactMap { $0 }
				.subscribe(onNext: { (image) in
					ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
					item.image = image
				})
				.disposed(by: disposeBag)
		}
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
		appImageView.image = nil
		appNameLabel.text = ""
		subTitleLabel.text = ""
		starLabel.text = ""
		imageViews.forEach {
			$0.image = nil
		}
	}
}

class ImageCacheManager {
	static let shared = NSCache<NSString, UIImage>()
	private init() {}
}
