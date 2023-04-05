//
//  ListBankView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import SwiftUI

struct ListBankView: View {
  @State var amount: Int
  @StateObject var listBankVM: ListBankViewModel
  @State private var showPickerPayFee = false
  @State private var optionSelectedFee = ""
  @State private var bankItem: BankListElement?
  @State private var isAlertPresent = false
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
      VStack{
        if listBankVM.error != nil{

          Text(Strings.textErrorApi)

        }else if let listBank = listBankVM.listBank, listBank.count > .zero{
          Text("\(Strings.textSelectBank)")
            .fontWeight(.bold)

          VStack(spacing: 8) {
            ScrollView(showsIndicators: false){
              ForEach(listBank, id: \.id) { item in
                Button {
                  bankItem = item
                  showPickerPayFee = true
                } label: {
                  BankCardCellView(itemBank: item)
                    .padding(4)
                }
              }
            }
          }
          .alert(isPresented: $isAlertPresent, content: {
            Alert(title: Text(Strings.textSuccesPay), message: Text(optionSelectedFee), dismissButton: .default(Text(Strings.buttonSuccesPay)))
          })
          .sheet(isPresented: $showPickerPayFee, onDismiss: {
            showPickerPayFee = false
          }, content: {
            if let bankItem = bankItem{
              PickerPayFeeView(optionSelected: $optionSelectedFee, payFeeVM: PickerPayFeeViewModel(id_payment: listBankVM.idPayment, amount: amount, issuer_id: bankItem.id), didSelectedPayFee: {
                showPickerPayFee = false
                isAlertPresent = true
                presentationMode.wrappedValue.dismiss()
              })
            }
          })
        }else{
          Text(Strings.textErrorGeneric)
        }
      }
      .padding()
      .navigationTitle(Strings.textTitle.uppercased())
      .navigationBarTitleDisplayMode(.inline)
      .onDisappear{
        presentationMode.wrappedValue.dismiss()
      }
    }
}

extension ListBankView {
  enum Strings{
    static let textSelectBank = "Seleccione Banco"
    static let textTitle = "Proceso de pago"
    static let textErrorApi = "Lo sentimos, no hemos podido cargar la información"
    static let textErrorGeneric = "Cargando ..."
    static let textSuccesPay = "Su pago fue realizado: "
    static let buttonSuccesPay = "OK"
  }
}

struct ListBankView_Previews: PreviewProvider {
    static var previews: some View {
      ListBankView(amount: 200, listBankVM: ListBankViewModel(id_payment: "dummy"))
    }
}
