public final class UIViewPropertyAnimatorSpy: UIViewPropertyAnimator {
    
    public private(set) var stopAnimationCalled = false
    public private(set) var stopAnimationWithoutFinishingPassed: Bool?
    
    override public func stopAnimation(_ withoutFinishing: Bool) {
        stopAnimationCalled = true
        stopAnimationWithoutFinishingPassed = withoutFinishing
    }
}
