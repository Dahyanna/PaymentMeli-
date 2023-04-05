//
//  ContentView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import SwiftUI

struct PaymentInputView: View {
  @State private var textValue = ""
  @State private var openPaymentMethod = false
  @State var amountSend: Int = .zero

    var body: some View {
      VStack(spacing: .zero) {
        TextField(Strings.textLabel, text: $textValue, onEditingChanged: { value in
          if !value, let amount = Int(textValue), amount > 0 {
            self.amountSend =  amount
          }
        })
        .foregroundColor(.black)
        .padding(.vertical, 8)
        .keyboardType(.numberPad)
        .foregroundColor(.white)
        .textContentType(.oneTimeCode)
        .multilineTextAlignment(TextAlignment.center)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.gray), lineWidth: 1))

        if let amount = Int(textValue), amount > 0 {
          NavigationLink {
            if self.amountSend != .zero {
              PaymentMethodListView(amount: self.amountSend)
            }
          } label: {
              Text(Strings.textButton)
                .padding()
          }
          .background(.yellow)
          .cornerRadius(8)
          .padding(.vertical, 16)
        }
      }
      .padding()
      .navigationTitle(Strings.textTitle.uppercased())
      .navigationBarTitleDisplayMode(.inline)
      .onAppear{
        self.amountSend = .zero
        self.textValue = ""
      }
    }
}


extension PaymentInputView {
  enum Strings{
    static let textLabel = "Ingrese Monto del Pago"
    static let textButton = "Pagar"
    static let textTitle = "Proceso de pago"
  }
}
struct PaymentInputView_Previews: PreviewProvider {
    static var previews: some View {
      PaymentInputView()
    }
}
