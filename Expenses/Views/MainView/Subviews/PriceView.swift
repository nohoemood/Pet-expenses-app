// PriceView.swift by mac 29.08.2026 

import Foundation
import SwiftUI

struct PriceView: View {

    public let title: String
//    public let amount: String
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - Title & amount
            HStack {
                Text(title)
                    .font(.system(size: 38))
                    .fontWeight(.bold)

                Spacer()

                Text(String(format: "$%.1f", mainViewModel.allPricesAmount))
                    .font(.system(size: 38))
                    .fontWeight(.bold)
                    .contentTransition(.numericText(countsDown: false))
                    .animation(.snappy, value: mainViewModel.allPricesAmount)
            }
            .padding(.horizontal, 26)
            .padding(.top, 32)

            // MARK: - Types of price
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 15) {
                    ForEach(mainViewModel.typesOfPrice, id: \.self) { typeOfPrice in
                        let isSelected = typeOfPrice == mainViewModel.selectedTypeOfPrice

                        Button(action: {
                            withAnimation(.smooth(duration: 0.45, extraBounce: 0.1)) {
                                mainViewModel.selectedTypeOfPrice = typeOfPrice
                            }
                        }) {
                            Text("\(typeOfPrice.rawValue)")
                                .font(.system(size: isSelected ? 22 : 18))
                                .fontWeight(isSelected ? .bold : .semibold)
                                .contentTransition(.interpolate)
                                .frame(width: isSelected ? 100 : 89, height: isSelected ? 33 : 29)
                                .background(isSelected ? typeOfPrice.color : typeOfPrice.color.opacity(0.55))
                                .cornerRadius(16)
                                .foregroundColor(.white)
                                .padding(.top, isSelected ? 22 : 24)
                                .shadow(
                                    color: isSelected ? typeOfPrice.color.opacity(0.25) : .clear,
                                    radius: isSelected ? 15 : 0,
                                    x: 0,
                                    y: 0
                                )
                                .frame(width: 90)
                                .scrollTransition { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1.0 : 0.0)
                                        .blur(radius: phase.isIdentity ? 0 : 8)
                                        .scaleEffect(phase.isIdentity ? 1.0 : 0.7)
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 26)
                .padding(.bottom, 24)
            }
            .scrollClipDisabled()

            Spacer()
        }
        .frame(width: 360, height: 155)
        .background(Color("Background_2"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("Stroke"), lineWidth: 1)
        )
    }
}
