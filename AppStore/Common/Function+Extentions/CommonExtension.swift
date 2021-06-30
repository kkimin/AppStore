//
//  CommonExtension.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//
// Extension 파일

import UIKit

// MARK: - UIView Extension

extension UIView {
	/**
	UIView Round 처리
	- Parameter corners: UIRectCorner : [.topRight, .topLeft, .bottomLeft, .bottomRight]
	- Parameter radius: radius 값
	- Returns: rounding 처리 된 UIView
	*/
	func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
		var cornerMask = CACornerMask()
		if(corners.contains(.topLeft)) {
			cornerMask.insert(.layerMinXMinYCorner)
		}
		if(corners.contains(.topRight)) {
			cornerMask.insert(.layerMaxXMinYCorner)
		}
		if(corners.contains(.bottomLeft)) {
			cornerMask.insert(.layerMinXMaxYCorner)
		}
		if(corners.contains(.bottomRight)) {
			cornerMask.insert(.layerMaxXMaxYCorner)
		}
		self.layer.cornerRadius = radius
		self.layer.maskedCorners = cornerMask
	}
}

// MARK: - Data Extension

extension Data {
	/// JSON Data를 예쁘게 String으로 변환
	var prettyPrintedJSONString: String {
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			  let prettyPrintedString = String(data: data, encoding: .utf8) else { return "" }
		return prettyPrintedString
	}
}
