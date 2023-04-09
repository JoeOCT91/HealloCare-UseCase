//
//  GamesView\.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

class GamesView: BaseView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(cellWithClass: GameTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
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
        layoutIfNeeded()
    }
}
