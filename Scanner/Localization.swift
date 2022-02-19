//
//  Localization.swift
//  Scanner
//
//  Created by VladyslavMac on 16.02.2022.
//

import Foundation

enum LocalizationKey: String {
	case cameraEdit = "camera_edit"
	case cameraShare = "camera_share"
	case cameraDelete = "camera_delete"
	case cameraShareAll = "camera_share_all"
	case cameraYourDocuments = "camera_your_documents"
	case camereScan = "camera_scan"
}

func LocalizedString(_ key: LocalizationKey) -> String {
	NSLocalizedString(key.rawValue, comment: "")
}
