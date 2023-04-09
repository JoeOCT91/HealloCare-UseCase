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
    
    private var overlayWindow: UIWindow? = {
        guard let scene = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first else { return nil}
        let window = UIWindow(windowScene: scene)
        
        return window
    }()
        
//    private var overlayIndicatorView: OverlayAnimatedIndicatorView = {
//        let view = OverlayAnimatedIndicatorView(frame: .zero)
//        view.alpha = 0
//        return view
//    }()
    
    var rollBackWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter {
                return $0.activationState == .foregroundActive
            }
            .compactMap { (scene: UIScene) -> UIWindowScene? in
                return (scene as? UIWindowScene)
            }
            .first?.windows
            .filter({$0.restorationIdentifier == "MainApplicationWindow"}).first
    }
    
    init() {
        super.init(frame: .zero)
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

        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }
    }
    
    @MainActor
    func displayAnimatedActivityIndicator(loadingType: LoadingType) {
//        scrollContentView.isUserInteractionEnabled = false
//        guard case .normal = loadingType else { return }
//
//        overlayIndicatorView.frame = overlayWindow?.frame ?? .zero
//        overlayIndicatorView.startAnimating()
//        overlayWindow?.addSubview(overlayIndicatorView)
//        overlayWindow?.makeKeyAndVisible()
//
//        UIView.animate(withDuration: 0.4) { [unowned self] in
//            overlayIndicatorView.alpha = 1
//        }
    }
    
    @MainActor
    func hideAnimatedLoadingIndicator(loadingType: LoadingType) {
//        scrollContentView.isUserInteractionEnabled = true
//        guard case .normal = loadingType else { return }
//
//        overlayIndicatorView.stopAnimating()
//        rollBackWindow?.makeKeyAndVisible()
//
//        UIView.animate(withDuration: 0.6 , delay: .zero, options: [.curveEaseOut]) { [weak self] in
//            guard let self else { return }
//            self.overlayIndicatorView.alpha = 0
//        }
    }
}



