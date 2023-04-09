//
//  File.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import Combine

class BaseViewController: UIViewController, AnyController {
    
    var subscriptions = Set<AnyCancellable>()
    var onAccountTapPublisher = PassthroughSubject<Void, Never>()

    private var baseViewModel: AnyViewModel
    private var baseView: BaseView? {
        return view as? BaseView
    }
    
    init(viewModel: AnyViewModel) {
        self.baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        let content = self.description + " Has been deinitialized "
        let dashed = String(repeating: "#", count: content.count)
        print(dashed)
        print(content)
        print(dashed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModelLoadingState()
        bindToMessagingStateDownstream()
    }
    
    private func bindToViewModelLoadingState() {
        baseViewModel.loadingStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] loadingState in
                switch loadingState {
                case .onLoading(let loadingType):
                    showLoader(loadingType)
                case.onFinishedLoading(let loadingType):
                    hideLoader(loadingType)
                }
            }.store(in: &subscriptions)
    }
    
    internal func showLoader(_ loadingType: LoadingType) {
        baseView?.displayAnimatedActivityIndicator(loadingType: loadingType)
    }
    
    internal func hideLoader(_ loadingType: LoadingType) {
        baseView?.hideAnimatedLoadingIndicator(loadingType: loadingType)
    }
    
    private func bindToMessagingStateDownstream() {
        baseViewModel.messagingStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { state in
                
            }.store(in: &subscriptions)
    }
}
