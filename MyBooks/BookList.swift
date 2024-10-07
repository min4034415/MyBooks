//
//  BookList.swift
//  MyBooks
//
//  Created by Ouimin Lee on 10/7/24.
//

import SwiftUI
import SwiftData

struct BookList: View {
    
    @Environment(\.modelContext) private var context
    @Query private var books: [Book]
    init(sortOrder:  SortOrder) {
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .title:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        case .author:
            [SortDescriptor(\Book.status), SortDescriptor(\Book.title)]
        }
    }
    var body: some View {
        Group{
            if books.isEmpty {
                ContentUnavailableView("Enter your first book.", systemImage: "book.fill")
            }
            else {
                List{
                    ForEach(books) { book in NavigationLink {
                        EditBookView(book: book)
                    } label: {
                        HStack(spacing:10){
                            book.icon
                            VStack(alignment: .leading) {
                                Text(book.title).font(.title2)
                                Text(book.author).foregroundStyle(.secondary)
                                if let rating = book.rating {
                                    HStack {
                                        ForEach(0..<rating, id: \.self) {
                                            _ in
                                            Image(systemName: "star.fill")
                                                .imageScale(.small)
                                                .foregroundStyle(.yellow)
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    }
                    .onDelete(perform: { indexSet in
                        indexSet.forEach {
                            index in
                            let book = books[index]
                            context.delete(book)
                        }
                    })
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    let preview = Preview(Book.self)
    preview.addExamples(Book.sampleBooks)
    return NavigationStack{
        BookList()
    }
        .modelContainer(preview.container)
}
