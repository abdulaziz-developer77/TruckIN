//
//  DVIRHeaderView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//

import SwiftUI

struct DVIRHeaderView: View {
    var onBack: () -> Void
    var onReload: () -> Void

    var body: some View {
        HStack {
          
            Button(action: onBack) {
                Image("back.icon")
                    .resizable()
                    .frame(width: 20, height: 20)
                    
            }
            .padding(.leading, 16)
            .padding(.top, 12)
            Text("DVIR")
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
                .padding(.top, 12)

           
            Button(action: onReload) {
                Image("reload.icon")
                    .resizable()
                    .frame(width: 20, height: 20)
                
            }
            .padding(.top, 14)
            .padding(.trailing, 16)
        }
        .padding(.bottom, 20)
      
    }
}


