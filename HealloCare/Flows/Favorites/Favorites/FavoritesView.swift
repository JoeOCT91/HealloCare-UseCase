//
//  FavoritesView.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import UIKit

class FavoritesView: BaseView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(cellWithClass: GameTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let emptyPlaceHolderLabel: UILabel = {
        let label = UILabel(text: L10n.noFavoritesPlaceHolder)
        label.font = FontFamily.SFProDisplay.medium.font(size: 18)
        label.backgroundColor = ColorName.white.color
        label.textColor = ColorName.black.color
        label.textAlignment = .center
        return label
    }()
    
    override init() {
        super.init()
        backgroundColor = ColorName.white.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViewsLayoutConstraints()
    }
    
    private func setupViewsLayoutConstraints() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(emptyPlaceHolderLabel)
        emptyPlaceHolderLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layoutIfNeeded()
    }
    
    func setEmptyFavoritesPlaceHolderVisibility(state: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.isHidden = state
            self.emptyPlaceHolderLabel.isHidden = !state
            self.emptyPlaceHolderLabel.alpha = state ? 1 : 0
            self.layoutIfNeeded()
        }
    }
}
