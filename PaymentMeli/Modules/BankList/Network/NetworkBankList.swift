//
//  NetworkBankList.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//


import Foundation

protocol NetworkBankListProtocol{
  func getListBank(payment_method_id: String, completion: @escaping(BankListResponse?, Error?) -> ())
}

class NetworkBankList: NetworkBankListProtocol{

  func getListBank(payment_method_id: String, completion: @escaping(BankListResponse?, Error?) -> ()) {

    let queryUrl = "\(ConstantGeneral.publicKey)&\(ConstantGeneral.listBankParams)\(payment_method_id)"

    guard let url = URL(string: "\(ConstantGeneral.apiBase)\(ConstantGeneral.apiListBank)?\(queryUrl)") else {
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
                  let listBank = try JSONDecoder().decode(BankListResponse.self, from: data)
                 completion(listBank, nil)
              } catch let error {
                completion(nil, ResponseError(type: .invalidJson(error)))
              }
          }else{
            completion(nil, ResponseError(type: .badStatusCode))
          }
      }
    } .resume()
  }
}

