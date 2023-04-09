//
//  GameTableViewCell.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Combine
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    var tapSubscriptions: AnyCancellable?
    var tapPublisher: AnyPublisher<Void, Never> {
        tapGesture.tapPublisher.flatMap { _ in
            return CurrentValueSubject<Void, Never>(())
        }.eraseToAnyPublisher()
    }
    
    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.kf.indicatorType = .activity
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
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        label.font = FontFamily.SFProDisplay.regular.font(size: 14)
        label.textColor = ColorName.darkGray.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let arrangedViews = [gameNameLabel, metacriticLabel, genresLabel]
        let stackView = UIStackView(arrangedSubviews: arrangedViews, axis: .vertical, alignment: .top, distribution: .fillProportionally)
        return stackView
    }()
    
    private let tapGesture = UITapGestureRecognizer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(tapGesture)
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
        
        containerView.addSubviews([image, gameNameLabel, metacriticLabel, genresLabel])
        
        containerView.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
            make.height.width.equalTo(120)
        }
        
        gameNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(16)
            make.top.trailing.equalToSuperview()
        }
        
        metacriticLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(gameNameLabel)
            make.top.greaterThanOrEqualTo(gameNameLabel.snp.bottom)
        }
        
        genresLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(gameNameLabel)
            make.top.equalTo(metacriticLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }

        layoutIfNeeded()
    }
}
