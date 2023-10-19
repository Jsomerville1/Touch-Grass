import UIKit

class HalfSizePresentationController: UIPresentationController {

    let backgroundView = UIView()

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let height = containerView.bounds.height * 8/9
        let yPosition = containerView.bounds.height - height
        return CGRect(x: 0, y: yPosition, width: containerView.bounds.width, height: height)
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.frame = containerView.bounds
        backgroundView.alpha = 0.0
        containerView.addSubview(backgroundView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 1.0
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 0.0
        }, completion: { _ in
            self.backgroundView.removeFromSuperview()
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    @objc func dismissController() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
