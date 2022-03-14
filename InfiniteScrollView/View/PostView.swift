//
//  PostView.swift
//  InfiniteScrollView
//
//  Created by M Kraay on 3/14/22.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject var posts: PostsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    InfiniteScrollView(data: posts.documents, tab: { (post: Post) -> PostTabView in
                        return PostTabView(post: post)
                    }, link: { (post: Post) -> PostLinkView in
                        return PostLinkView(post: post)
                    }, onAppear: {
                        posts.loadPosts(amount: 2)
                    }, onRefresh: {
                        posts.reset()
                        posts.loadPosts(amount: 2)
                    }, onLoadData: { document in
                        posts.loadMorePostsIfNeeded(current: document, amount: 2)
                    })
                    .overlay(alignment: .bottom) {
                        NavigationLink(destination: CreatePostView()) {
                            Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                            .padding(.bottom, 10)
                            .foregroundColor(Color.blue)
                        }
                    }
                }
            }
        }
    }
}

struct PostTabView: View {
    var post: Post

    // MARK: UI
    var body: some View {
        VStack {
            VStack {
                Text(post.title)
                Text(post.description)
            }
            .frame(maxWidth: .infinity, minHeight: 700)
            .background(Color(red: 173 / 255, green: 216 / 255, blue: 230 / 255))
            Divider()
        }
    }
}

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var posts: PostsViewModel
    @State var post: Post = Post()
    
    var body: some View {
        VStack {
            TextField("Title", text: $post.title)
            TextField("Description", text: $post.description)
            Button(action: {
                posts.createPost(title: post.title, description: post.description)
                dismiss()
            }) {
                Text("Submit")
            }
        }
    }
}

struct PostLinkView: View {
    var post: Post
    var body: some View {
        Text("\(post.title)")
        Text("\(post.description)")
    }
}
