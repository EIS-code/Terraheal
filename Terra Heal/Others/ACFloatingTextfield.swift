//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//


import UIKit

@IBDesignable
@objc open class ACFloatingTextfield: ThemeTextField {
    
    fileprivate var bottomLineView : UIView?
    fileprivate var labelPlaceholder : UILabel?
    fileprivate var labelErrorPlaceholder : UILabel?
    fileprivate var showingError : Bool = false
    fileprivate var bottomLineViewHeight : NSLayoutConstraint?
    fileprivate var placeholderLabelHeight : NSLayoutConstraint?
    fileprivate var errorLabelHieght : NSLayoutConstraint?
    let rightButton  = UIButton(type: .custom)
    /// Disable Floating Label when true.
    @IBInspectable open var disableFloatingLabel : Bool = false
    
    /// Shake Bottom line when Showing Error ?
    @IBInspectable open var shakeLineWithError : Bool = true
    
    /// Change Bottom Line Color.
    @IBInspectable open var lineColor : UIColor = UIColor.themePrimaryLight {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change line color when Editing in textfield
    @IBInspectable open var selectedLineColor : UIColor = UIColor.themePrimary{
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color.
    @IBInspectable open var placeHolderColor : UIColor = UIColor.themePrimary {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change placeholder color while editing.
    @IBInspectable open var selectedPlaceHolderColor : UIColor = UIColor.themePrimary {
        didSet{
            self.floatTheLabel()
        }
    }
    
    /// Change Error Text color.
    @IBInspectable open var errorTextColor : UIColor = UIColor.red{
        didSet{
            self.labelErrorPlaceholder?.textColor = errorTextColor
            self.floatTheLabel()
        }
    }
    
    /// Change Error Line color.
    @IBInspectable open var errorLineColor : UIColor = UIColor.red{
        didSet{
            self.floatTheLabel()
        }
    }
    
    //MARK:- Set Text
    override open var text:String?  {
        didSet {
            floatTheLabel()
        }
    }
    
    override open var placeholder: String? {
        willSet {
            if newValue != "" {
                self.labelPlaceholder?.text = newValue
            }
        }
    }
    
    open var errorText : String? {
        willSet {
            self.labelErrorPlaceholder?.text = newValue
        }
    }
    
    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.upadteTextField(frame: CGRect(x:self.frame.minX, y:self.frame.minY, width:rect.width, height:rect.height));
    }
    
    // MARK:- Loading From NIB
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    // MARK:- Intialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    // MARK:- Text Rect Management
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:0, y:4, width:bounds.size.width, height:bounds.size.height);
    }
    
    //MARK:- UITextfield Becomes First Responder
    override open func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.textFieldDidBeginEditing()
        return result
    }
    
    //MARK:- UITextfield Resigns Responder
    override open func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.textFieldDidEndEditing()
        return result
    }
    
   public func setupPasswordTextFielad() {

        self.rightButton.setImage(UIImage(named: "asset-password-show") , for: .normal)
        self.rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        self.rightButton.frame = CGRect(x:0, y:0, width:30, height:30)

        self.rightViewMode = .always
        self.rightView = rightButton
        self.isSecureTextEntry = true

    }
    
    
}

fileprivate extension ACFloatingTextfield {
    
    //MARK:- ACFLoating Initialzation.
    func initialize() -> Void {
        self.clipsToBounds = true
        self.textColor = UIColor.themePrimary
        self.setFont(name:FontName.Regular,size:FontSize.textField_20)
        addBottomLine()
        addFloatingLabel()
        if self.text != nil && self.text != "" {
            self.floatTheLabel()
        }
        addTarget(self, action: #selector(fix), for: .editingChanged)
    }
    
    //MARK:- ADD Bottom Line
    func addBottomLine(){

        if bottomLineView?.superview != nil {
            return
        }
        bottomLineView = UIView()
        bottomLineView?.backgroundColor = lineColor
        bottomLineView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomLineView!)
        let leadingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint.init(item: bottomLineView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        bottomLineViewHeight = NSLayoutConstraint.init(item: bottomLineView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        self.addConstraints([leadingConstraint,trailingConstraint,bottomConstraint])
        bottomLineView?.addConstraint(bottomLineViewHeight!)
        self.addTarget(self, action: #selector(self.textfieldEditingChanged), for: .editingChanged)
    }
    
    @objc func textfieldEditingChanged(){

    }
    
    //MARK:- ADD Floating Label
    func addFloatingLabel(){

        if labelPlaceholder?.superview != nil {
            return
        }
        var placeholderText : String? = labelPlaceholder?.text
        if self.placeholder != nil && self.placeholder != "" {
            placeholderText = self.placeholder!
        }
        labelPlaceholder = UILabel()
        labelPlaceholder?.text = placeholderText
        labelPlaceholder?.textAlignment = self.textAlignment
        labelPlaceholder?.textColor = placeHolderColor
        labelPlaceholder?.font = UIFont.init(name: (self.font?.fontName ?? "helvetica")!, size: JDDeviceHelper().fontCalculator(size: 12))
        labelPlaceholder?.isHidden = true
        labelPlaceholder?.sizeToFit()
        labelPlaceholder?.translatesAutoresizingMaskIntoConstraints = false
        self.changePlaceHolder(color: placeHolderColor)
        if labelPlaceholder != nil {
            self.addSubview(labelPlaceholder!)
        }
        let leadingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        placeholderLabelHeight = NSLayoutConstraint.init(item: labelPlaceholder!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375))
        self.addConstraints([leadingConstraint,trailingConstraint,topConstraint])
        labelPlaceholder?.addConstraint(placeholderLabelHeight!)
    }
    
    
    @objc func toggleShowHide(button: UIButton) {
        togglePasswordVisibility()
    }

    func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        if let textRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
            self.replace(textRange, withText: self.text!)
        }
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "asset-password-show") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "asset-password-hide") , for: .normal)
        }
    }
    //MARK:- Float & Resign
    func floatTheLabel() -> Void {
        DispatchQueue.main.async {
            if self.text == "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }else if self.text == "" && !self.isFirstResponder {
                self.resignPlaceholder()
            }else if self.text != "" && !self.isFirstResponder  {
                self.floatPlaceHolder(selected: false)
            }else if self.text != "" && self.isFirstResponder {
                self.floatPlaceHolder(selected: true)
            }
        }
    }
    
    //MARK:- Upadate and Manage Subviews
    func upadteTextField(frame:CGRect) -> Void {
        self.frame = frame;

        self.initialize()
    }
    
    //MARK:- Float UITextfield Placeholder Label
    func floatPlaceHolder(selected:Bool) -> Void {
        
        labelPlaceholder?.isHidden = false
        if selected {
            
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.selectedLineColor;
            labelPlaceholder?.textColor = self.selectedPlaceHolderColor;
            bottomLineViewHeight?.constant = 2;
            self.changePlaceHolder(color: self.selectedPlaceHolderColor)
            
        } else {
            bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
            bottomLineViewHeight?.constant = 1;
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.changePlaceHolder(color: self.placeHolderColor)
        }
        
        if disableFloatingLabel == true {
            labelPlaceholder?.isHidden = true
            return
        }
        
        if placeholderLabelHeight?.constant == JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375) {
            return
        }
        
        placeholderLabelHeight?.constant = JDDeviceHelper().offseter(offset: 15, direction: .horizontal, currentDeviceBound: 375);
        labelPlaceholder?.font = UIFont(name: (self.font?.fontName)!, size: JDDeviceHelper().fontCalculator(size: 12))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
        
    }
    
    //MARK:- Resign the Placeholder
    func resignPlaceholder() -> Void {
        
        self.changePlaceHolder(color: self.placeHolderColor)
        
        bottomLineView?.backgroundColor = showingError ? self.errorLineColor : self.lineColor;
        bottomLineViewHeight?.constant = 1;
        
        if disableFloatingLabel {
            
            labelPlaceholder?.isHidden = true
            self.labelPlaceholder?.textColor = self.placeHolderColor;
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            return
        }
        
        placeholderLabelHeight?.constant = self.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            self.labelPlaceholder?.font = self.font
            self.labelPlaceholder?.textColor = self.placeHolderColor
            self.layoutIfNeeded()
        }) { (finished) in
            self.labelPlaceholder?.isHidden = true
            self.placeholder = self.labelPlaceholder?.text
        }
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidBeginEditing() -> Void {
        
        if !self.disableFloatingLabel {
            self.placeholder = ""
        }
        self.floatTheLabel()
        self.layoutSubviews()
    }
    
    //MARK:- UITextField Begin Editing.
    func textFieldDidEndEditing() -> Void {
        self.floatTheLabel()
    }
}




extension UITextField {
    
    func changePlaceHolder(color: UIColor) {
        if #available(iOS 13, *) {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: color]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
        else {
            self.setValue(UIColor.themeLightTextColor, forKeyPath: "_placeholderLabel.textColor")
        }
    }
}
