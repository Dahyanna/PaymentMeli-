//
//  PaymentMethodListView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import SwiftUI

struct PaymentMethodListView: View {
  var amount: Int
  @ObservedObject private var pymentMethodVM = PymentMethodViewModel()

    var body: some View {
      VStack(alignment: .leading){
        if pymentMethodVM.error != nil{

          Text(Strings.textErrorApi)

        }else if let list = pymentMethodVM.listPM, list.count > 0 {

          HStack(spacing: 4){
            Spacer()
            Text(Strings.textAmount)
              .fontWeight(.bold)
              .foregroundColor(.gray)
            Text("\(amount)")
              .fontWeight(.bold)
          }

          VStack(spacing: 8) {
            ScrollView(showsIndicators: false){
              ForEach(list, id: \.id) { item in
                NavigationLink {
                  ListBankView(amount: amount, listBankVM: ListBankViewModel(id_payment: item.id))
                } label: {
                  PayCardCustomCellView(paymentMethod: item)
                    .padding(4)
                }
              }
            }
          }
        }
      }
      .padding()
      .navigationTitle(Strings.textSelectCard.uppercased())
      .navigationBarTitleDisplayMode(.inline)
    }
}

extension PaymentMethodListView {
  enum Strings{
    static let textSelectCard = "Seleccione forma de pago"
    static let textAmount = "Total:"
    static let textErrorApi = "Lo sentimos, no hemos podido cargar la información"
  }
}

struct PaymentMethodListView_Previews: PreviewProvider {
    static var previews: some View {
      PaymentMethodListView(amount: 10000)
    }
}
