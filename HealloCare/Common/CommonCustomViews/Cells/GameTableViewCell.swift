//
//  GameTableViewCell.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.numberOfLines = 0
        return label
    }()
    
    private let metacriticLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = FontFamily.SFProDisplay.regular.font(size: 14)
        label.textColor = ColorName.darkGray.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [gameNameLabel, metacriticLabel, genresLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with game: GameModel) {
        setMetacriticText(metacritic: game.metacritic.string)
        
        gameNameLabel.text = game.name
        genresLabel.text =  game.genres
        let imageURL = URL(string: game.image)
        image.kf.setImage(with: imageURL)
        layoutIfNeeded()
    }
    
    private func setMetacriticText(metacritic: String) {
        
        let metacriticTitle = L10n.metacritic
        let metacriticValue = metacritic
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: metacriticTitle, attributes: [.font: FontFamily.SFProDisplay.medium.font(size: 14),
                                                                                         .foregroundColor: UIColor.black]))
        attributedString.append(NSAttributedString(string: metacriticValue, attributes: [.font: FontFamily.SFProDisplay.medium.font(size: 18),
                                                                                         .foregroundColor: UIColor.red]))
        
        metacriticLabel.attributedText = attributedString
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setViewsLayoutConstraints()
    }
    
    private func setViewsLayoutConstraints() {
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            let edgesInsets = UIEdgeInsets(top: 16, left: 16, bottom: 18, right: 16)
            make.edges.equalToSuperview().inset(edgesInsets)
        }
        
        containerView.addSubview(image)
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.bottom.equalToSuperview().priority(.medium)
            make.height.width.equalTo(120)
        }
        
        containerView.addSubview(containerStack)
        containerStack.snp.makeConstraints { make in
            make.height.bottom.trailing.equalToSuperview()
            make.leading.equalTo(image.snp.trailing).offset(16)
        }
        layoutIfNeeded()
    }
}
