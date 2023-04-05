//
//  PaymentMethodModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

typealias PymentMethod = [PymentMethodElement]

// MARK: - PymentMethodElement
struct PymentMethodElement: Codable {
    let id, name: String
    let paymentTypeID: PaymentTypeID
    let status: Status
    let secureThumbnail: String
    let thumbnail: String
    let deferredCapture: DeferredCapture
    let settings: [Setting]
    let additionalInfoNeeded: [AdditionalInfoNeeded]
    let minAllowedAmount, maxAllowedAmount, accreditationTime: Int
    let processingModes: [String]

    enum CodingKeys: String, CodingKey {
        case id, name
        case paymentTypeID = "payment_type_id"
        case status
        case secureThumbnail = "secure_thumbnail"
        case thumbnail
        case deferredCapture = "deferred_capture"
        case settings
        case additionalInfoNeeded = "additional_info_needed"
        case minAllowedAmount = "min_allowed_amount"
        case maxAllowedAmount = "max_allowed_amount"
        case accreditationTime = "accreditation_time"
        case processingModes = "processing_modes"
    }
}

enum AdditionalInfoNeeded: String, Codable {
    case cardholderIdentificationNumber = "cardholder_identification_number"
    case cardholderIdentificationType = "cardholder_identification_type"
    case cardholderName = "cardholder_name"
    case issuerID = "issuer_id"
}

enum DeferredCapture: String, Codable {
    case doesNotApply = "does_not_apply"
    case supported = "supported"
    case unsupported = "unsupported"
}

enum PaymentTypeID: String, Codable {
    case creditCard = "credit_card"
    case debitCard = "debit_card"
    case ticket = "ticket"
}

// MARK: - Setting
struct Setting: Codable {
    let cardNumber: CardNumber
    let bin: Bin
    let securityCode: SecurityCode

    enum CodingKeys: String, CodingKey {
        case cardNumber = "card_number"
        case bin
        case securityCode = "security_code"
    }
}

// MARK: - Bin
struct Bin: Codable {
    let pattern, installmentsPattern: String
    let exclusionPattern: String?

    enum CodingKeys: String, CodingKey {
        case pattern
        case installmentsPattern = "installments_pattern"
        case exclusionPattern = "exclusion_pattern"
    }
}

// MARK: - CardNumber
struct CardNumber: Codable {
    let validation: Validation
    let length: Int
}

enum Validation: String, Codable {
    case none = "none"
    case standard = "standard"
}

// MARK: - SecurityCode
struct SecurityCode: Codable {
    let length: Int
    let cardLocation: CardLocation
    let mode: Mode

    enum CodingKeys: String, CodingKey {
        case length
        case cardLocation = "card_location"
        case mode
    }
}

enum CardLocation: String, Codable {
    case back = "back"
    case front = "front"
}

enum Mode: String, Codable {
    case mandatory = "mandatory"
    case modeOptional = "optional"
}

enum Status: String, Codable {
    case active = "active"
}

