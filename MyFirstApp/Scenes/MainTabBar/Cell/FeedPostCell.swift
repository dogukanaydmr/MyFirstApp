//
//  FeedPostCell.swift
//  MyFirstApp
//
//  Created by Doğukan Aydemir on 10.03.2026.
//

import UIKit

final class FeedPostCell: UITableViewCell {
    
    static let identifier = "FeedPostCell"
    
    weak var delegate: FeedPostCellDelegate?
    
    private var currentModel: FeedPostModel?
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        likeCountLabel.text = nil
        currentModel = nil
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .label
    }
}

private extension FeedPostCell {
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(containerView)
        containerView.addSubview(postImageView)
        containerView.addSubview(actionStackView)
        containerView.addSubview(likeCountLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            postImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor),
            
            actionStackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            actionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            actionStackView.heightAnchor.constraint(equalToConstant: 28),
            actionStackView.widthAnchor.constraint(equalToConstant: 120),
            
            likeCountLabel.topAnchor.constraint(equalTo: actionStackView.bottomAnchor, constant: 10),
            likeCountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            likeCountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            likeCountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension FeedPostCell {
    
    func configure(with model: FeedPostModel) {
        currentModel = model
        
        postImageView.image = model.image
        likeCountLabel.text = "\(model.likeCount) beğenme"
        updateLikeButtonAppearance(isLiked: model.isLiked)
    }
    
    func updateLikeState(isLiked: Bool, likeCount: Int) {
        likeCountLabel.text = "\(likeCount) beğenme"
        updateLikeButtonAppearance(isLiked: isLiked)
    }
    
    private func updateLikeButtonAppearance(isLiked: Bool) {
        let imageName = isLiked ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        likeButton.tintColor = isLiked ? .systemRed : .label
    }
}

private extension FeedPostCell {
    
    @objc func didTapLike() {
        delegate?.feedPostCellDidTapLike(self)
    }
    
    @objc func didTapComment() {
        delegate?.feedPostCellDidTapComment(self)
    }
    
    @objc func didTapShare() {
        delegate?.feedPostCellDidTapShare(self)
    }
}
