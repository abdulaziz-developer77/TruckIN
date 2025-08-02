//
//  DateTabBarView.swift
//  TruckIn
//
//  Created by Abdulaziz Boyqoziyev  on 7/30/25.
//
//

import SwiftUI

struct DateTabBarView: View {
    @Binding var selectedIndex: Int
    var dates: [String]
    var weekDays: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dates.indices, id: \.self) { i in
                    VStack(spacing: 2)  {
                        // hop buyerda hafta kunlari
                        Text(dates[i])
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(selectedIndex == i ? Color.white : Color(red: 53/255, green: 53/255, blue: 53/255, opacity: 1))
                        
                        // sanalar
                        Text(weekDays[i])
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(selectedIndex == i ? Color.white : Color(red: 125/255, green: 138/255, blue: 155/255, opacity: 1))
                    }
                    .frame(width: 80, height: 60)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                            
                            if selectedIndex == i {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                    .padding(3)
                            }
                        }
                    )
                    .onTapGesture {
                        selectedIndex = i
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
