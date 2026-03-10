//
//  FeedPostCellDelegate.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 10.03.2026.
//

protocol FeedPostCellDelegate: AnyObject {
    func feedPostCellDidTapLike(_ cell: FeedPostCell)
    func feedPostCellDidTapComment(_ cell: FeedPostCell)
    func feedPostCellDidTapShare(_ cell: FeedPostCell)
}
