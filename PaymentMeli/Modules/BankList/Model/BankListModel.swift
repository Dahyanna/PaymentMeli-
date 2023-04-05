//
//  BankListModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

typealias BankListResponse = [BankListElement]

struct BankListElement: Codable {
    let id, name: String
    let secureThumbnail, thumbnail: String
    let processingMode: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case processingMode = "processing_mode"
        case status
    }
}

