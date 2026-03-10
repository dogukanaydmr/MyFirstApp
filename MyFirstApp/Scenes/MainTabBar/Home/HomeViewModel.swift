//
//  HomeViewModel.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 9.03.2026.
//

import UIKit

protocol HomeViewModelProtocol {
    var posts: [FeedPostModel] { get set } 
}

final class HomeViewModel: HomeViewModelProtocol {
    
    var posts: [FeedPostModel] = [
        FeedPostModel(image: UIImage(named: "post1"), likeCount: 245, isLiked: false),
        FeedPostModel(image: UIImage(named: "post2"), likeCount: 1024, isLiked: true),
        FeedPostModel(image: UIImage(named: "post3"), likeCount: 89, isLiked: false)
    ]
}
