//
//  CommonConstants.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//


struct ValueSessionUser{
  static let token = "e9ad5ea37bb280db1c9b1fd71b11f931"
}

struct ConstantGeneral{
  static let publicKey = "public_key=444a9ef5-8a6b-429f-abdf-587639155d88"
  static let BASE = "https"
  static let apiBase = "https://api.mercadopago.com/v1/payment_methods"
  static let apiListBank = "/card_issuers"
  static let apiPayFee = "/installments"
  static let listBankParams = "payment_method_id="
  static let amountParam = "amount="
  static let issuerIDParam = "issuer.id="
}

struct ResponseError: Error {
    enum ErrorType {
        case invalidURL
        case badStatusCode
        case invalidJson(Error)
    }
    let type: ErrorType
}
