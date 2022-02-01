//
//  AppRoute.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation
import UIKit

enum PresentType {
    case root
    case push
    case present (withNav:Bool)
    case modal (withNav:Bool)
}


protocol IRouter {
    var module: UIViewController? { get }
}

extension UIViewController {
    static func initialModule<T: IRouter>(module: T) -> UIViewController {
        guard let currentModule = module.module else { fatalError() }
        return currentModule
    }
    
    func navigate(type: PresentType = .push, module: IRouter, completion: ((_ module: UIViewController) -> Void)? = nil) {
        guard let currentModule = module.module else { fatalError() }
        switch type {
        case .root:
            // swiftlint:disable identifier_name
            let vc = self.shoRootViewController(module)
            completion?(vc)
        case .push:
            if let navigation = self.navigationController {
                navigation.pushViewController(currentModule, animated: true)
                completion?(currentModule)
            }
        case .present(let withNav):
            let nav = withNav ? UINavigationController(rootViewController: currentModule):nil
            self.present(nav ?? currentModule, animated: true) {
                completion?(currentModule)
            }
        case .modal(let withNav):
            self.showModalViewController(currentModule, withNav: withNav, completion: completion)
        }
    }
    
    func dismiss(to: IRouter? = nil, _ completion: (() -> Void)? = nil) {
        if self.navigationController != nil {
            self.navigationController?.dismiss(animated: true) {
                completion?()
                return
            }
            
            if let module = to?.module, let viewControllers = self.navigationController?.viewControllers {
                if let currentVc = viewControllers.first(where: { type(of: $0) == type(of: module) }) {
                    self.navigationController?.popToViewController(currentVc, animated: true)
                }
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            completion?()
        } else {
            self.dismiss(animated: true) {
                completion?()
            }
        }
    }
    
    func backToRoot(_ completion: (() -> Void)? = nil) {
        self.navigationController?.popToRootViewController(animated: true)
        completion?()
    }
    
    func getNavigate(module : IRouter) -> UIViewController {
        guard let moduleVC = module.module else { fatalError() }
        // swiftlint:disable force_cast
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        if moduleVC is UITabBarController {
            sceneDelegate.window?.setRootViewController(moduleVC, options: .init(direction: .fade, style: .easeInOut))
        } else {
            sceneDelegate.window?.setRootViewController(
                UINavigationController(rootViewController: moduleVC),
                options: .init(
                    direction: .fade,
                    style: .easeInOut
                )
            )
        }
        return moduleVC
    }
    
    // MARK: - private methods
    private func shoRootViewController (_ module:IRouter) -> UIViewController {
        guard let moduleVC = module.module else { fatalError() }
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        if module is UITabBarController {
            sceneDelegate.window?.setRootViewController(moduleVC, options: .init(direction: .fade, style: .easeInOut))
        } else if module is UINavigationController {
            sceneDelegate.window?.setRootViewController(moduleVC, options: .init(direction: .fade, style: .easeInOut))
        } else {
            let rootNC = UINavigationController(rootViewController: moduleVC)
            sceneDelegate.window?.setRootViewController(rootNC, options: .init( direction: .fade, style: .easeInOut )
            )
        }
        return moduleVC
    }
    
    private func showModalViewController (_ module:UIViewController, withNav:Bool, completion: ((_ module: UIViewController) -> Void)?) {
        module.modalTransitionStyle = .crossDissolve
        module.modalPresentationStyle = .overFullScreen
        let nav = withNav ? UINavigationController(rootViewController: module):nil
        self.present(nav ?? module, animated: true) {
            completion?(module)
        }
    }
}

extension UIViewController {
    private struct UniqueIdProperies {
        static var pickerDelegate: IDataPickerDelegate?
        static var previousViewController: UIViewController?
    }
    
    // MARK: - Picker Delegate Properties
    
    weak var dataPickerDelegate: IDataPickerDelegate? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.pickerDelegate) as? IDataPickerDelegate
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.pickerDelegate, unwrappedValue as IDataPickerDelegate?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    var previousViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &UniqueIdProperies.previousViewController) as? UIViewController
        } set {
            if let unwrappedValue = newValue {
                objc_setAssociatedObject(self, &UniqueIdProperies.previousViewController,
                                         unwrappedValue as UIViewController?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
}

public extension UIWindow {
    /// Transition Options
    struct TransitionOptions {
        /// Curve of animation
        ///
        /// - linear: linear
        /// - easeIn: ease in
        /// - easeOut: ease out
        /// - easeInOut: ease in - ease out
        // swiftlint:disable nesting
        public enum Curve {
            case linear
            case easeIn
            case easeOut
            case easeInOut
            
            /// Return the media timing function associated with curve
            internal var function: CAMediaTimingFunction {
                let key: String!
                switch self {
                case .linear: key = CAMediaTimingFunctionName.linear.rawValue
                case .easeIn: key = CAMediaTimingFunctionName.easeIn.rawValue
                case .easeOut: key = CAMediaTimingFunctionName.easeOut.rawValue
                case .easeInOut: key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
                }
                return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key!))
            }
        }
        
        /// Direction of the animation
        ///
        /// - fade: fade to new controller
        /// - toTop: slide from bottom to top
        /// - toBottom: slide from top to bottom
        /// - toLeft: pop to left
        /// - toRight: push to right
        // swiftlint:disable nesting
        public enum Direction {
            case fade
            case toTop
            case toBottom
            case toLeft
            case toRight
            
            /// Return the associated transition
            ///
            /// - Returns: transition
            internal func transition() -> CATransition {
                let transition = CATransition()
                transition.type = CATransitionType.push
                switch self {
                case .fade:
                    transition.type = CATransitionType.fade
                    transition.subtype = nil
                case .toLeft:
                    transition.subtype = CATransitionSubtype.fromLeft
                case .toRight:
                    transition.subtype = CATransitionSubtype.fromRight
                case .toTop:
                    transition.subtype = CATransitionSubtype.fromTop
                case .toBottom:
                    transition.subtype = CATransitionSubtype.fromBottom
                }
                return transition
            }
        }
        
        /// Background of the transition
        ///
        /// - solidColor: solid color
        /// - customView: custom view
        // swiftlint:disable nesting
        public enum Background {
            case solidColor(_: UIColor)
            case customView(_: UIView)
        }
        
        /// Duration of the animation (default is 0.20s)
        public var duration: TimeInterval = 0.20
        
        /// Direction of the transition (default is `toRight`)
        public var direction: TransitionOptions.Direction = .toRight
        
        /// Style of the transition (default is `linear`)
        public var style: TransitionOptions.Curve = .linear
        
        /// Background of the transition (default is `nil`)
        public var background: TransitionOptions.Background?
        
        /// Initialize a new options object with given direction and curve
        ///
        /// - Parameters:
        ///   - direction: direction
        ///   - style: style
        public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
            self.direction = direction
            self.style = style
        }
        
        /// Return the animation to perform for given options object
        internal var animation: CATransition {
            let transition = self.direction.transition()
            transition.duration = self.duration
            transition.timingFunction = self.style.function
            return transition
        }
    }
    
    /// Change the root view controller of the window
    ///
    /// - Parameters:
    ///   - controller: controller to set
    ///   - options: options of the transition
    func setRootViewController(_ controller: UIViewController, options: TransitionOptions = TransitionOptions()) {
        var transitionWnd: UIWindow?
        if let background = options.background {
            transitionWnd = UIWindow(frame: UIScreen.main.bounds)
            switch background {
            case .customView(let view):
                transitionWnd?.rootViewController = UIViewController.newController(withView: view, frame: transitionWnd!.bounds)
            case .solidColor(let color):
                transitionWnd?.backgroundColor = color
            }
            transitionWnd?.makeKeyAndVisible()
        }
        
        // Make animation
        self.layer.add(options.animation, forKey: kCATransition)
        self.rootViewController = controller
        self.makeKeyAndVisible()
        
        if let wnd = transitionWnd {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 + options.duration) {
                wnd.removeFromSuperview()
            }
        }
    }
}

// MARK: - Common Protocol Delegate

protocol IDataPickerDelegate: AnyObject {
    func didDataPicker<T>(_ data: T?)
}

