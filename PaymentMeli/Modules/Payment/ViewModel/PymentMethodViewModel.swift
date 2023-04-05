//
//  PymentMethodViewModel.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import Foundation
import Combine

class PymentMethodViewModel: ObservableObject {
  private var data: NetworkPaymentMethod
  private var didChange = PassthroughSubject<[PymentMethodElement], Error>()

  init(data: NetworkPaymentMethod = NetworkPaymentMethod()){
    self.data = data
    self.getListPymentMethod()
  }

  @Published var error: Error? = nil {
    didSet{
      if let error = error{
        didChange.send(completion: .failure(error))
      }
    }
  }

  @Published var listPM = [PymentMethodElement]() {
      didSet {
          didChange.send(listPM)
      }
  }

  private func getListPymentMethod(){
    data.getPaymentMethod { pymentMethod, error in
      if let list = pymentMethod {
        self.listPM = list
      }
      if let error = error{
        self.error = error
      }
    }
  }
}
