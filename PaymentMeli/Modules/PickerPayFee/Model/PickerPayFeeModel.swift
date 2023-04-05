//
//  PickerPayFeeModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 05-04-23.
//

import Foundation

typealias PayFeeResponse = [PayFeeResponseElement]

// MARK: - PayFeeResponseElement
struct PayFeeResponseElement: Codable {
    let paymentMethodID, paymentTypeID: String
    let issuer: Issuer
    let payerCosts: [PayerCost]

    enum CodingKeys: String, CodingKey {
        case paymentMethodID = "payment_method_id"
        case paymentTypeID = "payment_type_id"
        case issuer
        case payerCosts = "payer_costs"
    }
}

// MARK: - Issuer
struct Issuer: Codable {
    let id, name: String
    let secureThumbnail: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
    }
}

// MARK: - PayerCost
struct PayerCost: Codable {
    let recommendedMessage: String

    enum CodingKeys: String, CodingKey {
        case recommendedMessage = "recommended_message"
    }
}

