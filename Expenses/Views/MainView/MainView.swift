import SwiftUI

struct MainView: View {

    @StateObject private var mainViewModel = MainViewModel()

    @State private var showCreateExpenseView: Bool = false

    var body: some View {

        NavigationStack {
            ZStack {
                Color("Background_1")
                    .ignoresSafeArea()
                VStack {
                    PriceView(title: "Prices", mainViewModel: mainViewModel)
                    Spacer()
                    ExpenseRowView(mainViewModel: mainViewModel)
                        .padding(.top, 27)
//                        .contextMenu {
//                            Button(role: .destructive) {
//                                // Вызываешь метод удаления из твоей ViewModel
//                                mainViewModel.removeExpense(expense: <#T##Expense#>)
//                            } label: {
//                                Label("Удалить", systemImage: "trash")
//                            }
//
//                            // Если нужно, сюда можно добавить и другие действия
//                            Button {
//                                // Логика редактирования
//                            } label: {
//                                Label("Редактировать", systemImage: "pencil")
//                            }
//                        }
                }
                .padding(.top, 14)
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            // MARK: ToolBar -
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showCreateExpenseView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            // MARK: Sheet -
            .sheet(isPresented: $showCreateExpenseView) {
                NavigationStack {
                    ExpenseViewWrapper { title, amount, category in
                        mainViewModel.addExpense(name: title, price: amount, typeOfExpense: category)
                        showCreateExpenseView = false
                    }
                    .ignoresSafeArea()
                    .navigationTitle("New Expense")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                showCreateExpenseView = false
                            }) {
                                Image(systemName: "xmark")
                            }
                        }
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                }
                .interactiveDismissDisabled(true)
                .presentationDetents([.fraction(0.73)])
            }
        }
    }
}
