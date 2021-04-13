//
//  ListRowItemView.swift
//  Devote
//
//  Created by Mabast on 4/11/21.
//

import SwiftUI

struct ListRowItemView: View {
    @Environment(\.managedObjectContext) var viewContext
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @ObservedObject var item: Item
    var body: some View {
        Toggle(isOn: $item.completion){
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .strikethrough(item.completion ? true : false, color: isDarkMode == true ? .white : .black)
                .padding(.vertical, 12)
                .animation(.default)
        }
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        })
    }
}

