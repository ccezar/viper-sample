import UIKit

public final class NavigationControllerSpy: UINavigationController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
    
    public private(set) var pushViewControllersPassed: [UIViewController] = []
    public private(set) var pushViewControllerCalled = false
    public private(set) var pushViewControllerPassed: UIViewController?
    public private(set) var pushViewControllerAnimatedPassed: Bool?
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllersPassed.append(viewController)
        pushViewControllerCalled = true
        pushViewControllerPassed = viewController
        pushViewControllerAnimatedPassed = animated
    }
    
    public private(set) var popToRootViewControllerCalled = false
    public private(set) var popToRootViewControllerAnimatedPassed: Bool?
    public var popToRootViewControllerViewControllersToBeReturned: [UIViewController]?
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootViewControllerCalled = true
        popToRootViewControllerAnimatedPassed = animated
        return popToRootViewControllerViewControllersToBeReturned
    }
    
    public private(set) var setViewControllersCalled = false
    public private(set) var setViewControllersAnimatedPassed: Bool?
    public var setViewControllersToBeReturned: [UIViewController]?
    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        setViewControllersCalled = true
        setViewControllersAnimatedPassed = animated
        setViewControllersToBeReturned = viewControllers
    }
	
	public private(set) var popViewControllerCalled = false
    public private(set) var popViewControllerAnimatedPassed: Bool?
    public var popViewControllerToBeReturned: UIViewController?
	
	public override func popViewController(animated: Bool) -> UIViewController? {
		popViewControllerCalled = true
        popViewControllerAnimatedPassed = animated
		return popViewControllerToBeReturned
	}
	
	public private(set) var showViewControllerCalled = false
	public private(set) var showSenderPassed: Any?
	public private(set) var showViewControllerPassed: UIViewController?
	
	public override func show(_ vc: UIViewController, sender: Any?) {
		showViewControllerCalled = true
		showSenderPassed = sender
		showViewControllerPassed = vc
	}
	
	public private(set) var popToViewControllerCalled = false
	public private(set) var popToViewControllerPassed: UIViewController?
	public var popToViewControllersToBeReturned: [UIViewController]?
	
	public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
		popToViewControllerCalled = true
		popToViewControllerPassed = viewController
		return popToViewControllersToBeReturned
	}
}
