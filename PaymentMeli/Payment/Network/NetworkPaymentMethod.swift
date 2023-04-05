//
//  NetworkPaymentMethod.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import Foundation

protocol NetworkPaymentMethodProtocol{
  func getPaymentMethod(completion: @escaping(PymentMethod?, Error?) -> ())
}

class NetworkPaymentMethod: NetworkPaymentMethodProtocol{

  func getPaymentMethod(completion: @escaping(PymentMethod?, Error?) -> ()) {
    guard let url = URL(string: "\(ConstantGeneral.apiPayment)?\(ConstantGeneral.publicKey)") else {
      completion(nil, ResponseError(type: .invalidURL))
      return
    }
    URLSession.shared.dataTask(with: url) { data, success, error in
        guard let data = data, error == nil, let response = success as? HTTPURLResponse else {
          completion(nil, ResponseError(type: .badStatusCode))
            return
        }
      if response.statusCode == 200 {
            do {
                let listPayment = try JSONDecoder().decode(PymentMethod.self, from: data)

                DispatchQueue.main.async {
                  completion(listPayment, nil)
                }
            } catch let error {
              completion(nil, ResponseError(type: .invalidJson(error)))
            }
        }else{
          completion(nil, ResponseError(type: .badStatusCode))
        }
    } .resume()
  }
}
