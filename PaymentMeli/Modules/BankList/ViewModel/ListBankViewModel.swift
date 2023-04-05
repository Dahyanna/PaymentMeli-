//
//  ListBankViewModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//


import Foundation
import Combine

class ListBankViewModel: ObservableObject {
  private var data: NetworkBankList
  var idPayment: String

  private var didChange = PassthroughSubject<[BankListElement], Error>()

  init(id_payment: String, data: NetworkBankList = NetworkBankList()){
    self.idPayment = id_payment
    self.data = data
    self.getListBank(method_id: self.idPayment)
  }

  @Published var error: Error? = nil {
    didSet{
      if let error = error{
        didChange.send(completion: .failure(error))
      }
    }
  }

  @Published var listBank = [BankListElement]() {
      didSet {
          didChange.send(listBank)
      }
  }

  private func getListBank(method_id: String){
    data.getListBank(payment_method_id: method_id) { list, error in
      if let listBank = list {
        self.listBank = listBank
      }
      if let error = error{
        self.error = error
      }
    }
  }
}

