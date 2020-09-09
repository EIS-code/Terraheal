//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeView: UIView {
    

}
class ThemeTopGradientView: UIView {
    var gradientLayer: CAGradientLayer? = nil
    @IBInspectable open var enableGradient : Bool = false {
           didSet{
               self.addGradientFade()
           }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    override func layoutSubviews() {
        self.gradientLayer?.frame = self.bounds
    }
    
    func addGradientFade() {
        if enableGradient {
                gradientLayer =  CAGradientLayer()
                let gradientColor = UIColor.white
                gradientLayer!.frame = self.bounds
                gradientLayer!.colors = [gradientColor.withAlphaComponent(1.0).cgColor,gradientColor.withAlphaComponent(0.8).cgColor, gradientColor.withAlphaComponent(0.5).cgColor,gradientColor.withAlphaComponent(0.0).cgColor]
                gradientLayer!.name = "gradient"

                if let oldLayer:  CAGradientLayer = self.layer.sublayers?.last(where: { (currentLayer) -> Bool in
                    return currentLayer.name == "topGradient"
                }) as?  CAGradientLayer {
                    oldLayer.removeFromSuperlayer()
                }
            self.layer.addSublayer(gradientLayer!)
        } else {
            gradientLayer = nil
        }
    }
}

class ThemeBottomGradientView: UIView {
    var gradientLayer: CAGradientLayer? = nil
    @IBInspectable open var enableGradient : Bool = false {
           didSet{
               self.addGradientFade()
           }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        self.addGradientFade()
    }
    override func layoutSubviews() {
        
        self.gradientLayer?.frame = self.bounds
    }
    
    func addGradientFade() {
        if enableGradient {
                gradientLayer =  CAGradientLayer()
                let gradientColor = UIColor.white
                gradientLayer!.frame = self.bounds
                gradientLayer!.colors = [gradientColor.withAlphaComponent(0.0).cgColor,gradientColor.withAlphaComponent(0.5).cgColor, gradientColor.withAlphaComponent(0.8).cgColor,gradientColor.withAlphaComponent(1.0).cgColor]
                gradientLayer!.name = "gradient"

                if let oldLayer:  CAGradientLayer = self.layer.sublayers?.last(where: { (currentLayer) -> Bool in
                    return currentLayer.name == "topGradient"
                }) as?  CAGradientLayer {
                    oldLayer.removeFromSuperlayer()
                }
            self.layer.addSublayer(gradientLayer!)
        } else {
            gradientLayer = nil
        }
    }
}


extension UIView {
    
    
    func height(constant: CGFloat) {
        setConstraint(value: constant, attribute: .height)
    }

    func width(constant: CGFloat) {
        setConstraint(value: constant, attribute: .width)
    }

    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: -2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
    }
    func setDurationCellShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    func setHomeBottomMenuShadow() {
           self.layer.masksToBounds = false
           self.layer.shadowRadius = 2.0
           self.layer.shadowOpacity = 0.22
           self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowColor = UIColor.themeShadowColor.cgColor
       }
    
    private func removeConstraint(attribute: NSLayoutConstraint.Attribute) {
        constraints.forEach {
            if $0.firstAttribute == attribute {
                removeConstraint($0)
            }
        }
    }

    private func setConstraint(value: CGFloat, attribute: NSLayoutConstraint.Attribute) {
        removeConstraint(attribute: attribute)
        let constraint =
            NSLayoutConstraint(item: self,
                               attribute: attribute,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: nil,
                               attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1,
                               constant: value)
        self.addConstraint(constraint)
    }
}
//MARK: Dashed UIView
extension UIView {

    func createDashedLine(from point1: CGPoint, to point2: CGPoint, color: UIColor, strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()

        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        let path = CGMutablePath()
        path.addLines(between: [point1, point2])
        shapeLayer.path = path
        shapeLayer.name = "dashed"
        if let oldLayer:  CAShapeLayer = layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "dashed"
        }) as?  CAShapeLayer {
            oldLayer.removeFromSuperlayer()
        }
        layer.addSublayer(shapeLayer)
    }

}
class DashedLineView: UIView {

    private let borderLayer = CAShapeLayer()
    private let radius: CGFloat = 10

    override func awakeFromNib() {

        super.awakeFromNib()

        borderLayer.strokeColor = UIColor.themePrimary.cgColor
        borderLayer.lineDashPattern = [3,3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor

        layer.addSublayer(borderLayer)
    }

    override func draw(_ rect: CGRect) {

        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath
        print("\(self)-\(rect)")
    }
}


//MARK:- Shake
extension UIView {
    func shake() {
        let force = 1.0
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.rotation"
        animation.values = [0, 0.2*force, -0.2*force, 0.3*force, 0]
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        animation.duration = CFTimeInterval(0.3)
        animation.isAdditive = true
        animation.repeatCount = 1
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(0.1)
        layer.add(animation, forKey: "swing")
    }
}

//MARK:- Custom Segment Control
class CustomSegmentedControl: UISegmentedControl {

    override func layoutSubviews(){

        super.layoutSubviews()

        //corner radius
        let cornerRadius = bounds.height/2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: 5, dy: 5)
            foregroundImageView.image = UIImage()
            foregroundImageView.highlightedImage = UIImage()
            foregroundImageView.backgroundColor = UIColor.themePrimary
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true

            foregroundImageView.layer.cornerRadius = 14
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
    }
}

