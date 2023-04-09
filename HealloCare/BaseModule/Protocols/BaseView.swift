//
//  BaseView.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

class BaseView: UIView {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        return scrollView
    }()
    
    var scrollContentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = ColorName.white.color
        hideKeyboardWhenTappedAround()
        setupViewsLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViewsLayoutConstraints()
    }
    
    private func hideKeyboardWhenTappedAround() {
          let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tap.cancelsTouchesInView = false
          addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }

    private func setupViewsLayoutConstraints() {

    }
    
    func displayAnimatedActivityIndicator(loadingType: LoadingType) {

    }
    
    func hideAnimatedLoadingIndicator(loadingType: LoadingType) {

    }
}



