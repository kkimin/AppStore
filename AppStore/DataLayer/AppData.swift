//
//  AppData.swift
//  AppStore
//
//  Created by 기민주 on 6/21/21.
//

import Foundation

struct InquiryModel: Codable {
	let resultCount: Int?
	let list: [AppModel]

	private enum CodingKeys: String, CodingKey {
		case resultCount
		case list = "results"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.resultCount = try container.decodeIfPresent(Int.self, forKey: .resultCount)
		self.list = try container.decodeIfPresent(Array.self, forKey: .list) ?? []
	}
}

struct AppModel: Codable {
	let trackName: String			// 아티스트 이름
	let collectionName: String		// 오른쪽 정보
	let trackViewUrl: String
	let artworkUrl60: String	// app image
	let releaseDate: String
	let screenshotUrls: [String]
	let releaseNotes: String
	let description: String

	private enum CodingKeys: String, CodingKey {
		case trackName
		case collectionName
		case trackViewUrl
		case artworkUrl60
		case releaseDate
		case screenshotUrls
		case releaseNotes
		case description
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
		self.collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName) ?? ""
		self.trackViewUrl = try container.decodeIfPresent(String.self, forKey: .trackViewUrl) ?? ""
		self.artworkUrl60 = try container.decodeIfPresent(String.self, forKey: .artworkUrl60) ?? ""
		self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
		self.screenshotUrls = try container.decodeIfPresent([String].self, forKey: .screenshotUrls) ?? []
		self.releaseNotes = try container.decodeIfPresent(String.self, forKey: .releaseNotes) ?? ""
		self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
	}
}
