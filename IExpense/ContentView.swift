//
//  ContentView.swift
//  IExpense
//
//  Created by roger deutsch on 7/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    private static var counter = 0
    @State private var isShowingExpense = false
    @Environment(\.locale) var locale: Locale

    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code:locale.currency?.identifier ?? "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    isShowingExpense.toggle()
//                    ContentView.counter += 1
//                    let expense = ExpenseItem( name: "Test \(ContentView.counter)", type: "Personal", amount: 5 )
//                    expenses.items.append(expense)
                    
                } label:{
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isShowingExpense) {
                AddView(expenses: expenses)
            }
       }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(expenses: Expenses())
    }
}
