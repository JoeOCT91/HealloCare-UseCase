//
//  GameDetailsView.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import UIKit

class GameDetailsView: BaseView {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle(L10n.favorite, for: .normal)
        button.setTitle(L10n.favorited, for: .selected)
        button.setTitleColorForAllStates(.systemBlue)
        return button
    }()

    private lazy var containerStackView: UIStackView = {
        let arrangedViews = [descriptionTitleLabel, descriptionLabel, sepLine, visitRedditButton, sepLine, visitWebsiteButton, sepLine]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, spacing: 16)
        return stackView
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.SFProDisplay.bold.font(size: 36)
        label.textColor = ColorName.white.color
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel(text: L10n.gameDescription)
        label.font = FontFamily.SFProDisplay.regular.font(size: 17)
        label.textColor = ColorName.black.color
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.SFProDisplay.regular.font(size: 10)
        label.numberOfLines = 5
        return label
    }()
    
    private let visitRedditButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleForAllStates(L10n.visitReddit)
        button.setTitleColorForAllStates(ColorName.black.color)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = FontFamily.SFProDisplay.regular.font(size: 17)
        return button
    }()
    
    private let visitWebsiteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleForAllStates(L10n.visitWebsite)
        button.setTitleColorForAllStates(ColorName.black.color)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = FontFamily.SFProDisplay.regular.font(size: 17)
        return button
    }()
    
    var sepLine: UIView {
        let view = UIView(frame: .zero)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = ColorName.lightGray.color
        return view
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(with game: GameModel) {
        
        gameTitleLabel.text = game.name
        descriptionLabel.text = game.desc.htmlToString
        
        let gameImageURL = URL(string: game.image)
        gameImageView.kf.setImage(with: gameImageURL)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewsLayoutConstraints()
    }
    
    private func setupViewsLayoutConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        contentView.addSubview(gameImageView)
        gameImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(gameImageView.snp.width)
        }
        
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.top.equalTo(gameImageView.snp.bottom).offset(16)
        }
        
        addSubview(gameTitleLabel)
        gameTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(gameImageView).inset(16)
        }
        layoutIfNeeded()
    }
}
