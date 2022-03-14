//
//  InfiniteScrollView.swift
//  InfiniteScrollView
//
//  Created by M Kraay on 3/13/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct InfiniteScrollView<Tab: View, Link: View, Data: Codable>: View {
    let data: [DocumentSnapshot]
    let tab: (Data) -> Tab
    let link: (Data) -> Link
    let onAppear: () -> ()
    let onRefresh: () -> ()
    let onLoadData: (DocumentSnapshot) -> ()
    
    init(data: [DocumentSnapshot], tab: @escaping (Data) -> Tab, link: @escaping (Data) -> Link,
         onAppear: @escaping () -> (), onRefresh: @escaping () -> (), onLoadData: @escaping (DocumentSnapshot) -> ()) {
        self.data = data
        self.tab = tab
        self.link = link
        self.onAppear = onAppear
        self.onRefresh = onRefresh
        self.onLoadData = onLoadData
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        List {
            ForEach(data, id: \.self) { document in
                let castedDocument = try? document.data(as: Data.self)
                HStack(spacing: 0) {
                    tab(castedDocument!)
                    NavigationLink(destination: link(castedDocument!)) {
                        EmptyView()
                    }
                    .frame(width: 0)
                    .opacity(0)
                    .navigationBarHidden(true) // Removing the banner on the next page (1)
                    .navigationBarTitleDisplayMode(.inline) // (2)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .onAppear {
                    DispatchQueue.main.async {
                        onLoadData(document)
                    }
                }
            }
        }
        .navigationBarHidden(true) // Fixes the refresh (1)
        .navigationBarTitleDisplayMode(.inline) // (2)
        .listStyle(.plain)
        .refreshable {
            DispatchQueue.main.async {
                onRefresh()
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                onAppear()
            }
        }
    }
}
