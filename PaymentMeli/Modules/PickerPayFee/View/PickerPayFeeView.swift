//
//  PickerPayFeeView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 05-04-23.
//

import SwiftUI

struct PickerPayFeeView: View {
  @Binding var optionSelected: String
  @StateObject var payFeeVM: PickerPayFeeViewModel
  var didSelectedPayFee: () -> Void

    var body: some View {
      VStack{
        if let list = payFeeVM.payFeeList, list.payerCosts.count > .zero {
          Button {
            didSelectedPayFee()
          } label: {
            Text("Seleccionar")
          }
          .padding(.bottom, 32)

          Picker("Seleccione Cuota", selection: $optionSelected) {
            ForEach(list.payerCosts, id: \.recommendedMessage) {
              Text($0.recommendedMessage).tag($0.recommendedMessage)
            }
          }
          .pickerStyle(.wheel)
          .animation(nil, value: UUID())
        }else if payFeeVM.error != nil {
          Text("No encontramos información")
        }else{
          Text("Cargando ...")
        }
      }
      .onChange(of: payFeeVM.firtsItemSelect, perform: { newValue in
        optionSelected = payFeeVM.firtsItemSelect
      })
    }
}
