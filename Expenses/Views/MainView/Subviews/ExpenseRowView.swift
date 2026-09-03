// ExpenseRowView.swift by mac 30.08.2026 

import Foundation
import SwiftUI

struct ExpenseRowView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 19) {
                ForEach(mainViewModel.filteredExpenses) { expense in
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(expense.name)")
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                            Text("\(expense.typeOfExpense.rawValue)")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                        }
                        .padding(.leading, 26)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 3) {
                            Text(String(format: "$%.1f", expense.price))
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                            
                            HStack(spacing: 5) {
                                ForEach(0..<3) { index in
                                    Capsule()
                                        .fill(index < expense.typeOfPrice.activeDashes ? expense.typeOfPrice.color : expense.typeOfPrice.color.opacity(0.25))
                                        .frame(width: 25, height: 10)
                                }
                            }
                            .frame(width: 90, height: 15)
                            .background(Color(.white).opacity(0.07))
                            .cornerRadius(16)
                        }
                        .padding(.trailing, 26)
                    }
                    .frame(width: 360, height: 105)
                    .background(Color("Background_2"))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("Stroke"), lineWidth: 1)
                    )
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                            .blur(radius: phase.isIdentity ? 0 : 8)
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            mainViewModel.removeExpense(expense: expense)
                        } label: {
                            Label("Удалить", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .scrollClipDisabled()
    }
}
