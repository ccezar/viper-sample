import UIKit

public typealias UIViewControllerDummy = UIViewControllerSpy

public final class UIViewControllerSpy: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    public private(set) var presentCalled = false
    public private(set) var presentViewControllerPassed: UIViewController?
    public private(set) var presentAnimatedPassed: Bool?
    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        presentViewControllerPassed = viewControllerToPresent
        presentAnimatedPassed = flag
        completion?()
    }
}
