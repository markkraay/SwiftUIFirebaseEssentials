//
//  Post.swift
//  InfiniteScrollView
//
//  Created by M Kraay on 3/13/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ScrollableData {}

struct Post: Codable, ScrollableData {
    @ServerTimestamp var createdTime: Timestamp?
    var title: String = ""
    var description: String = ""
}
