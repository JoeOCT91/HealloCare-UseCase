//
//  WeakRouter.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

final class WeakRouter: NSObject, AnyRouter {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
        
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            self?.rootController?.dismiss(animated: animated, completion: completion)
        }
    }
    
    func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBar: Bool)  {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),(controller is UINavigationController == false)
        else { assertionFailure("Deprecated push UINavigationController."); return }
        
            if let completion = completion {
                self.completions[controller] = completion
            }
            
            controller.hidesBottomBarWhenPushed = hideBottomBar
            self.rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule()  {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.isNavigationBarHidden = hideBar
        rootController?.setViewControllers([controller], animated: false)
    }
        
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    func popToController(of Kind: UIViewController.Type) {
        guard let controllers = rootController?.viewControllers else { return }
        for controller in controllers where controller.isKind(of: Kind) {
            rootController?.popToViewController(controller, animated: true)
        }
    }
    
    func popViewController(of kind: UIViewController.Type) {
        rootController?.viewControllers.removeAll(where: { $0.isKind(of: kind) })
    }

    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    deinit {
        let content = self.description + " Has been deinitialized "
        let dashed = String(repeating: "#", count: content.count)
        print(dashed)
        print(content)
        print(dashed)
    }
}
