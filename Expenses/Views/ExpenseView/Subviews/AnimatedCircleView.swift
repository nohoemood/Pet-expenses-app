// AnimatedCircleView.swift by mac 02.09.2026 

import Foundation
import UIKit

class AnimatedCircleView: UIView {
    
    private let progressLayer = CAShapeLayer()
    private var currentProgress: CGFloat = 0.0
    
    private let dollarLabel: UILabel = {
        let label = UILabel()
        
        label.text = "$"
        label.font = UIFont.systemFont(ofSize: 54, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        
        addSubview(dollarLabel)
        NSLayoutConstraint.activate([
            dollarLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dollarLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) / 2) - 3
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)
        
        progressLayer.path = path.cgPath
    }
    
    private func setupLayers() {
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 4
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        
        progressLayer.shadowOffset = .zero
        progressLayer.shadowRadius = 8.0 
        progressLayer.shadowOpacity = 0.6
        
        layer.addSublayer(progressLayer)
    }
    
    func setInitialState(color: UIColor) {
        progressLayer.strokeColor = color.cgColor
        progressLayer.shadowColor = color.cgColor
        progressLayer.strokeEnd = 0
    }
    
    func animateProgress(to amount: Double, color: UIColor) {
        progressLayer.strokeColor = color.cgColor
        progressLayer.shadowColor = color.cgColor
        
        let targetProgress = CGFloat(min(max(amount / 1500.0, 0.0), 1.0))
        progressLayer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = currentProgress
        animation.toValue = targetProgress
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        progressLayer.strokeEnd = targetProgress
        progressLayer.add(animation, forKey: "fillCircle")
        
        currentProgress = targetProgress
    }
}
