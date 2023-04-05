//
//  BankCardCellView.swift
//  PaymentMeli
//
//  Created by Dahyanna Hernández on 04-04-23.
//

import SwiftUI

struct BankCardCellView: View {
  var itemBank: BankListElement

    var body: some View {
      HStack(spacing: 8){
        if let img = URL(string: itemBank.secureThumbnail){
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
        Text(itemBank.name)
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

struct BankCardCellView_Previews: PreviewProvider {
    static var previews: some View {
      BankCardCellView(itemBank: BankListElement(id: "dummy", name: "dummy", secureThumbnail: "dummy", thumbnail: "dummy", processingMode: "dummy", status: "dummy"))
    }
}
