//
//  PayCardCustomCellView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import SwiftUI

struct PayCardCustomCellView: View {
  var paymentMethod: PymentMethodElement

    var body: some View {
      HStack(spacing: 8){
        if let img = URL(string: paymentMethod.secureThumbnail){
          AsyncImage(url: img) { image in
                  image
                      .resizable()
                      .scaledToFit()
                      .transition(.slide)
                      .frame(width: 48, height: 32)
              } placeholder: {
                  Image(systemName: "creditcard.fill")
              }
        }
        Text(paymentMethod.name)
          .font(Font(CTFont(.label, size: 24)))
          .fontWeight(.bold)
        Spacer()
        Image(systemName: "chevron.forward")
          .padding(.trailing, 4)
      }
      .padding()
      .background(.white)
      .cornerRadius(8)
      .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(.gray), lineWidth: 2))
    }
}

struct PayCardCustomCellView_Previews: PreviewProvider {
    static var previews: some View {
      PayCardCustomCellView(paymentMethod: PymentMethodElement(id: "naranja", name: "naranja", paymentTypeID: PaymentTypeID.creditCard, status: Status.active, secureThumbnail: "https://http2.mlstatic.com/storage/logos-api-admin/770edaa0-5dc7-11ec-a13d-73e40a9e9500-xl@2x.png", thumbnail: "https://http2.mlstatic.com/storage/logos-api-admin/770edaa0-5dc7-11ec-a13d-73e40a9e9500-xl@2x.png", deferredCapture: DeferredCapture.doesNotApply, settings: [Setting.init(cardNumber: CardNumber(validation: .standard, length: 0), bin: Bin(pattern: "dummy", installmentsPattern: "Dummy", exclusionPattern: "Dummy"), securityCode: SecurityCode(length: 0, cardLocation: CardLocation.front, mode: Mode.mandatory))], additionalInfoNeeded: [AdditionalInfoNeeded.issuerID], minAllowedAmount: 0, maxAllowedAmount: 0, accreditationTime: 0, processingModes: ["Dummy"]))
    }
}
