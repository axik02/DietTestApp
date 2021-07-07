//
//  Extension+ActivityIndicatorView.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

fileprivate let overlayViewTag: Int = 999
fileprivate let activityIndicatorViewTag: Int = 1000

// MARK: - Public interface

extension UIView {
    func displayAnimatedActivityIndicatorView(color: UIColor, style: UIActivityIndicatorView.Style, onTop: Bool = false) {
        setActivityIndicatorView(color: color, style: style, onTop: onTop)
    }
    func hideAnimatedActivityIndicatorView() {
        removeActivityIndicatorView()
    }
}
extension UIViewController {
    private var overlayContainerView: UIView {
        if let navigationView: UIView = navigationController?.view {
            return navigationView
        }
        return view
    }
    func displayAnimatedActivityIndicatorView(color: UIColor, style: UIActivityIndicatorView.Style, onTop: Bool = false) {
        overlayContainerView.displayAnimatedActivityIndicatorView(color: color, style: style, onTop: onTop)
    }
    func hideAnimatedActivityIndicatorView() {
        overlayContainerView.hideAnimatedActivityIndicatorView()
    }
}

// MARK: - Private interface

extension UIView {
    private var activityIndicatorView: UIActivityIndicatorView {
        let view: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                view = UIActivityIndicatorView(style: .large)
            default:
                view = UIActivityIndicatorView(style: .medium)
            }
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = activityIndicatorViewTag
        return view
    }
    private var overlayView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.alpha = 0.5
        view.tag = overlayViewTag
        return view
    }
    private func setActivityIndicatorView(color: UIColor, style: UIActivityIndicatorView.Style, onTop: Bool) {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        let overlayView: UIView = self.overlayView
        let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView
        activityIndicatorView.color = color
        activityIndicatorView.style = style
        //add subviews
        overlayView.addSubview(activityIndicatorView)
        addSubview(overlayView)
        //add overlay constraints
        overlayView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        overlayView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        //add indicator constraints
        activityIndicatorView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor).isActive = true
        if onTop {
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        } else {
            activityIndicatorView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor).isActive = true
        }
        //animate indicator
        activityIndicatorView.startAnimating()
    }
    private func removeActivityIndicatorView() {
        guard let overlayView: UIView = getOverlayView(), let activityIndicator: UIActivityIndicatorView = getActivityIndicatorView() else {
            return
        }
        UIView.animate(withDuration: 0.2, animations: {
            overlayView.alpha = 0.0
            activityIndicator.stopAnimating()
        }) { _ in
            activityIndicator.removeFromSuperview()
            overlayView.removeFromSuperview()
        }
    }
    private func isDisplayingActivityIndicatorOverlay() -> Bool {
        getActivityIndicatorView() != nil && getOverlayView() != nil
    }
    private func getActivityIndicatorView() -> UIActivityIndicatorView? {
        viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView
    }
    private func getOverlayView() -> UIView? {
        viewWithTag(overlayViewTag)
    }
}
