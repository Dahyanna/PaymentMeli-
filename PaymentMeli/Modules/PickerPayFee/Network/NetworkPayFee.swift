//
//  NetworkPayFee.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 05-04-23.
//


import Foundation

protocol NetworkPayFeeProtocol{
  func getPayFeeList(payment_method_id: String, amount: Int, issuer_id: String, completion: @escaping(PayFeeResponse?, Error?) -> ())
}

class NetworkPayFee: NetworkPayFeeProtocol {

  func getPayFeeList(payment_method_id: String, amount: Int, issuer_id: String, completion: @escaping(PayFeeResponse?, Error?) -> ()) {

    let queryUrl = "\(ConstantGeneral.publicKey)&\(ConstantGeneral.listBankParams)\(payment_method_id)&\(ConstantGeneral.amountParam)\(amount)" +
    "&\(ConstantGeneral.issuerIDParam)\(issuer_id)"

    guard let url = URL(string: "\(ConstantGeneral.apiBase)\(ConstantGeneral.apiPayFee)?\(queryUrl)") else {
      completion(nil, ResponseError(type: .invalidURL))
      return
    }
    URLSession.shared.dataTask(with: url) { data, success, error in
        guard let data = data, error == nil, let response = success as? HTTPURLResponse else {
          completion(nil, ResponseError(type: .badStatusCode))
            return
        }
      DispatchQueue.main.async {
        if response.statusCode == 200 {
              do {
                  let listPayFee = try JSONDecoder().decode(PayFeeResponse.self, from: data)
                  completion(listPayFee, nil)
              } catch let error {
                print(error.localizedDescription)
                completion(nil, ResponseError(type: .invalidJson(error)))
              }
          }else{
            completion(nil, ResponseError(type: .badStatusCode))
          }
      }
    } .resume()
  }
}


