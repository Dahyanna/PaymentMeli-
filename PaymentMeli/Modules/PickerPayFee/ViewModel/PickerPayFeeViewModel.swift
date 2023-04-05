//
//  PickerPayFeeViewModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 05-04-23.
//

import Foundation
import Combine

class PickerPayFeeViewModel: ObservableObject {
  private var data: NetworkPayFee
  private var didChange = PassthroughSubject<PayFeeResponseElement, Error>()
  var firtsItemSelect = ""

  init(id_payment: String, amount: Int, issuer_id: String, data: NetworkPayFee = NetworkPayFee()){
    self.data = data
    self.getListPayFee(method_id: id_payment, amount: amount, issuer_id: issuer_id)
  }

  @Published var error: Error? = nil {
    didSet{
      if let error = error{
        didChange.send(completion: .failure(error))
      }
    }
  }

  @Published var payFeeList: PayFeeResponseElement? {
      didSet {
        if let payfee = payFeeList{
          didChange.send(payfee)
        }
      }
  }

  private func getListPayFee(method_id: String, amount: Int, issuer_id: String){
    data.getPayFeeList(payment_method_id: method_id, amount: amount, issuer_id: issuer_id){ list, error in
      if let response = list, let listPayFee = response.first {
        self.payFeeList = listPayFee
        if let itemFirst = listPayFee.payerCosts.first?.recommendedMessage {
          self.firtsItemSelect = itemFirst
        }
      }
      if let error = error{
        self.error = error
      }
    }
  }
}


