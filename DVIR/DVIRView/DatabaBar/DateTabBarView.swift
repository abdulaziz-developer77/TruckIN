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

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(dates.indices, id: \.self) { i in
                        let isSelected = selectedIndex == i

                        VStack(spacing: 4) {
                            Text(dates[i])
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(isSelected ? .white : .black90)

                            Text(weekDays[i])
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(isSelected ? .white : .gray100)
                        }
                        .frame(width: itemWidth, height: 80)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)

                                if isSelected {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.primary100)
                                        .padding(3)
                                }
                            }
                        )
                        .contentShape(Rectangle()) 
                        .onTapGesture {
                            withAnimation {
                                selectedIndex = i
                                proxy.scrollTo(i, anchor: .center)
                            }
                        }
                        .id(i)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var itemWidth: CGFloat {
        let screen = UIScreen.main.bounds.size
        let isLandscape = screen.width > screen.height
        let isPad = UIDevice.current.userInterfaceIdiom == .pad

        if isPad {
            return isLandscape ? 146.5 : 87.55
        } else {
            return 80
        }
    }
    
    private var itemSpacing: CGFloat {
        let screen = UIScreen.main.bounds.size
        let isLandscape = screen.width > screen.height
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        
        if  isPad {
            return isLandscape ? 12 : 10
        } else {
            return 8
        }
    }
}

