//
//  EditBookView.swift
//  MyBooks
//
//  Created by Ouimin Lee on 9/30/24.
//

import SwiftUI

struct EditBookView: View {
//    let book: Book
    @State private var status = Status.onShelf
    @State private var rating: Int?
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    
    var body: some View {
        HStack{
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) {
                    status in
                    Text(status.descr).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    EditBookView()
}
