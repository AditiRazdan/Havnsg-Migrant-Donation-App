import Foundation
import UIKit

// MARK: DesignableView
import UIKit
@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableImage: UIImageView {
}

private var maxLengthDictionary = [UITextField : Int]()
private var leftPaddingDict =  [UITextField : CGFloat]()
private var rightPaddingDict = [UITextField : CGFloat]()


extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = maxLengthDictionary[self] {
                return length
            } else {
                return Int.max
            }
        }
        set {
            maxLengthDictionary[self] = newValue
            addTarget(self, action: #selector(checkMaxLength(sender:)), for: UIControl.Event.editingChanged)
        }
    }
    
    
    @objc func checkMaxLength(sender: UITextField) {
        let newText = sender.text
        if (newText?.count)! > maxLength {
            let cursorPosition = selectedTextRange
            text = (newText! as NSString).substring(with: NSRange(location: 0, length: maxLength))
            selectedTextRange = cursorPosition
        }
    }
    
    @IBInspectable var leftPadding: CGFloat{
        get {
            if let length = leftPaddingDict[self] {
                return length
            } else {
                return 0.0
            }
        }
        set {
            leftPaddingDict[self] = newValue
            setLeftPaddingPoints(padding: newValue)
        }
    }
    
    @IBInspectable
    var rightPadding: CGFloat{
        get {
            if let length = rightPaddingDict[self] {
                return length
            } else {
                return 0.0
            }
        }
        set {
            rightPaddingDict[self] = newValue
            setRightPaddingPoints(padding: newValue)
        }
    }
    
    func setLeftPaddingPoints(padding : CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(padding : CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = UIColor.clear.cgColor
            }
        }
    }
    
}

@IBDesignable
class CustomTextField: UITextField {
    
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateUnderLineFrame()
    }
    
    func updateView()
    {
        applyUnderLine()
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: tintColor!])
    }
    
    /// Sets the placeholder color
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    // MARK: - Underline
    private var underLineLayer = CALayer()
    private func applyUnderLine() {
        // Apply underline only if the text view's has no borders
        //if borderStyle == UITextField.BorderStyle.none {
        underLineLayer.removeFromSuperlayer()
        updateUnderLineFrame()
        updateUnderLineUI()
        layer.addSublayer(underLineLayer)
        layer.masksToBounds = true
        // }
    }
    
    private func updateUnderLineFrame() {
        var rect = bounds
        rect.origin.y = bounds.height - underLineWidth
        rect.size.height = underLineWidth
        underLineLayer.frame = rect
    }
    private func updateUnderLineUI() {
        underLineLayer.backgroundColor = underLineColor.cgColor
    }
    /// Applies underline to the text view with the specified width
    @IBInspectable public var underLineWidth: CGFloat = 0.0 {
        didSet {
            updateUnderLineFrame()
        }
    }
    
    /// Sets the underline color
    @IBInspectable public var underLineColor: UIColor = .groupTableViewBackground {
        didSet {
            updateUnderLineUI()
        }
    }
}
@IBDesignable
class CustomSlider: UISlider {
    /// custom slider track height
    @IBInspectable var trackHeight: CGFloat = 3
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        // Use properly calculated rect
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
}
@IBDesignable
open class CustomTextView: UITextView {
    
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    
    public let placeholderLabel: UILabel = UILabel()
    
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    /** Border color for the text view */
    
    
    
    @IBInspectable open var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable open var placeholderColor: UIColor = CustomTextView.Constants.defaultiOSPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    
    open var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
        #endif
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: notificationName,
                                               object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
                                                            options: [],
                                                            metrics: nil,
                                                            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
                                                         options: [],
                                                         metrics: nil,
                                                         views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    deinit {
        #if swift(>=4.2)
        let notificationName = UITextView.textDidChangeNotification
        #else
        let notificationName = NSNotification.Name.UITextView.textDidChangeNotification
        #endif
        
        NotificationCenter.default.removeObserver(self,
                                                  name: notificationName,
                                                  object: nil)
    }
    
}


@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}



@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}



public protocol DPOTPViewDelegate {
    func dpOTPViewAddText(_ text:String , at position:Int)
    func dpOTPViewRemoveText(_ text:String , at position:Int)
    func dpOTPViewChangePositionAt(_ position:Int)
    func dpOTPViewBecomeFirstResponder()
    func dpOTPViewResignFirstResponder()
}

@IBDesignable open class DPOTPView: UIView {
    
    /** The number of textField that will be put in the DPOTPView */
    @IBInspectable open dynamic var count: Int = 4
    
    /** Spaceing between textField in the DPOTPView */
    @IBInspectable open dynamic var spacing: CGFloat = 8
    
    /** Text color for the textField */
    @IBInspectable open dynamic var textColorTextField: UIColor = UIColor.black
    
    /** Text font for the textField */
    @IBInspectable open dynamic var fontTextField: UIFont = UIFont.systemFont(ofSize: 25)
    
    /** Placeholder */
    @IBInspectable open dynamic var placeholder: String = ""
    
    /** Placeholder text color for the textField */
    @IBInspectable open dynamic var placeholderTextColor: UIColor = UIColor.gray
    
    /** Circle textField */
    @IBInspectable open dynamic var isCircleTextField: Bool = false
    
    /** Allow only Bottom Line for the TextField */
    @IBInspectable open dynamic var isBottomLineTextField: Bool = true
    
    /** Background color for the textField */
    @IBInspectable open dynamic var backGroundColorTextField: UIColor = UIColor.clear
    
    /** Background color for the filled textField */
    @IBInspectable open dynamic var backGroundColorFilledTextField: UIColor?
    
    /** Border color for the TextField */
    @IBInspectable open dynamic var borderColorTextField: UIColor?
    
    /** Border color for the TextField */
    @IBInspectable open dynamic var selectedBorderColorTextField: UIColor?
    
    /** Border width for the TextField */
    @IBInspectable open dynamic var borderWidthTextField: CGFloat = 0.0
    
    /** Border width for the TextField */
    @IBInspectable open dynamic var selectedBorderWidthTextField: CGFloat = 0.0
    
    /** Corner radius for the TextField */
    @IBInspectable open dynamic var cornerRadiusTextField: CGFloat = 0.0
    
    /** Tint/cursor color for the TextField */
    @IBInspectable open dynamic var tintColorTextField: UIColor = UIColor.systemBlue
    
    /** Shadow Radius for the TextField */
    @IBInspectable open dynamic var shadowRadiusTextField: CGFloat = 0.0
    
    /** Shadow Opacity for the TextField */
    @IBInspectable open dynamic var shadowOpacityTextField: Float = 0.0
    
    /** Shadow Offset Size for the TextField */
    @IBInspectable open dynamic var shadowOffsetSizeTextField: CGSize = .zero
    
    /** Shadow color for the TextField */
    @IBInspectable open dynamic var shadowColorTextField: UIColor?
    
    /** Dismiss keyboard with enter last character*/
    @IBInspectable open dynamic var dismissOnLastEntry: Bool = false
    
    /** Secure Text Entry*/
    @IBInspectable open dynamic var isSecureTextEntry: Bool = false
    
    /** Hide cursor*/
    @IBInspectable open dynamic var isCursorHidden: Bool = false
    
    /** Dark keyboard*/
    @IBInspectable open dynamic var isDarkKeyboard: Bool = false
    
    open dynamic var textEdgeInsets : UIEdgeInsets?
    open dynamic var editingTextEdgeInsets : UIEdgeInsets?
    
    open dynamic var dpOTPViewDelegate : DPOTPViewDelegate?
    open dynamic var keyboardType:UIKeyboardType = UIKeyboardType.numberPad
    
    open dynamic var text : String? {
        get {
            var str = ""
            arrTextFields.forEach { str.append($0.text ?? "") }
            return str
        } set {
            arrTextFields.forEach { $0.text = nil }
            for i in 0 ..< arrTextFields.count {
                if i < (newValue?.count ?? 0) {
                    if let txt = newValue?[i..<i+1] , let code = Int(txt) {
                        arrTextFields[i].text = String(code)
                    }
                }
            }
        }
    }
    
    fileprivate var arrTextFields : [OTPBackTextField] = []
    /** Override coder init, for IB/XIB compatibility */
    #if !TARGET_INTERFACE_BUILDER
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /** Override common init, for manual allocation */
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.initialization()
    }
    #endif
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initialization()
    }
    
    func initialization() {
        if arrTextFields.count != 0 { return }
        
        let sizeTextField = (self.bounds.width/CGFloat(count)) - (spacing)
        
        for i in 1 ... count {
            let textField = OTPBackTextField()
            textField.delegate = self
            textField.OTPBackDelegate = self
            textField.dpOTPView = self
            textField.borderStyle = .none
            textField.tag = i * 1000
            textField.tintColor = tintColorTextField
            textField.backgroundColor = backGroundColorTextField
            textField.isSecureTextEntry = isSecureTextEntry
            textField.font = fontTextField
            textField.keyboardAppearance = isDarkKeyboard ? .dark : .default
            if isCursorHidden { textField.tintColor = .clear }
            if isBottomLineTextField {
                let border = CALayer()
                border.name = "bottomBorderLayer"
                textField.removePreviouslyAddedLayer(name: border.name ?? "")
                border.backgroundColor = borderColorTextField?.cgColor
                border.frame = CGRect(x: 0, y: sizeTextField - borderWidthTextField,width : sizeTextField ,height: borderWidthTextField)
                textField.layer.addSublayer(border)
            } else {
                textField.layer.borderColor = borderColorTextField?.cgColor
                textField.layer.borderWidth = borderWidthTextField
                if isCircleTextField {
                    textField.layer.cornerRadius = sizeTextField / 2
                } else {
                    textField.layer.cornerRadius = cornerRadiusTextField
                }
            }
            textField.layer.shadowRadius = shadowRadiusTextField
            if let shadowColorTextField = shadowColorTextField {
                textField.layer.shadowColor = shadowColorTextField.cgColor
            }
            textField.layer.shadowOpacity = shadowOpacityTextField
            textField.layer.shadowOffset = shadowOffsetSizeTextField
            
            textField.textColor = textColorTextField
            textField.textAlignment = .center
            textField.keyboardType = keyboardType
            if #available(iOS 12.0, *) {
                textField.textContentType = .oneTimeCode
            }
            
            if placeholder.count > i - 1 {
                textField.attributedPlaceholder = NSAttributedString(string: placeholder[i - 1],
                attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
            }
            
            textField.frame = CGRect(x:(CGFloat(i-1) * sizeTextField) + (CGFloat(i) * spacing/2) + (CGFloat(i-1) * spacing/2)  , y: (self.bounds.height - sizeTextField)/2 , width: sizeTextField, height: sizeTextField)
            
            arrTextFields.append(textField)
            self.addSubview(textField)
            if isCursorHidden {
                let tapView = UIView(frame: self.bounds)
                tapView.backgroundColor = .clear
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                tapView.addGestureRecognizer(tap)
                self.addSubview(tapView)
            }
        }
    }
    
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//
//        super.draw(rect)
//    }

    
    open override func becomeFirstResponder() -> Bool {
        if isCursorHidden {
            for i in 0 ..< arrTextFields.count {
                if arrTextFields[i].text?.count == 0 {
                    _ = arrTextFields[i].becomeFirstResponder()
                    break
                } else if (arrTextFields.count - 1) == i {
                    _ = arrTextFields[i].becomeFirstResponder()
                    break
                }
            }
        } else {
            _ = arrTextFields[0].becomeFirstResponder()
        }
        dpOTPViewDelegate?.dpOTPViewBecomeFirstResponder()
        return super.becomeFirstResponder()
    }
    
    open override func resignFirstResponder() -> Bool {
        arrTextFields.forEach { (textField) in
            _ = textField.resignFirstResponder()
        }
        dpOTPViewDelegate?.dpOTPViewResignFirstResponder()
        return super.resignFirstResponder()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        _ = self.becomeFirstResponder()
    }
    
    func validate() -> Bool {
        var isValid = true
        arrTextFields.forEach { (textField) in
            if Int(textField.text ?? "") == nil {
                isValid = false
            }
        }
        return isValid
    }
}

extension DPOTPView : UITextFieldDelegate , OTPBackTextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        dpOTPViewDelegate?.dpOTPViewChangePositionAt(textField.tag/1000 - 1)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.trimmingCharacters(in: CharacterSet.whitespaces).count != 0 {
            textField.text = string
            if textField.tag < count*1000 {
                let next = textField.superview?.viewWithTag((textField.tag/1000 + 1)*1000)
                next?.becomeFirstResponder()
            } else if textField.tag == count*1000 && dismissOnLastEntry {
                textField.resignFirstResponder()
            }
        } else if string.count == 0 { // is backspace
            textField.text = ""
        }
        dpOTPViewDelegate?.dpOTPViewAddText(text ?? "", at: textField.tag/1000 - 1)
        return false
    }
    
    func textFieldDidDelete(_ textField: UITextField) {
        if textField.tag > 1000 , let next = textField.superview?.viewWithTag((textField.tag/1000 - 1)*1000) as? UITextField {
            next.text = ""
            next.becomeFirstResponder()
            dpOTPViewDelegate?.dpOTPViewRemoveText(text ?? "", at: next.tag/1000 - 1)
        }
    }
}

protocol OTPBackTextFieldDelegate {
    func textFieldDidDelete(_ textField : UITextField)
}


fileprivate class OTPBackTextField: UITextField {
    
    var OTPBackDelegate : OTPBackTextFieldDelegate?
    weak var dpOTPView : DPOTPView!
    override var text: String? {
        didSet {
            if text?.isEmpty ?? true {
                self.backgroundColor = dpOTPView.backGroundColorTextField
            } else {
                self.backgroundColor = dpOTPView.backGroundColorFilledTextField ?? dpOTPView.backGroundColorTextField
            }
        }
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        OTPBackDelegate?.textFieldDidDelete(self)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.copy(_:)) ||
//            action == #selector(UIResponderStandardEditActions.cut(_:)) ||
//            action == #selector(UIResponderStandardEditActions.select(_:)) ||
//            action == #selector(UIResponderStandardEditActions.selectAll(_:)) ||
//            action == #selector(UIResponderStandardEditActions.delete(_:)) {
//
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
        return false
    }
    
    override func becomeFirstResponder() -> Bool {
        addSelectedBorderColor()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        addUnselectedBorderColor()
        return super.resignFirstResponder()
    }
    
    fileprivate func addSelectedBorderColor() {
        if let selectedBorderColor = dpOTPView.selectedBorderColorTextField {
            if dpOTPView.isBottomLineTextField {
                addBottomLine(selectedBorderColor, width: dpOTPView.selectedBorderWidthTextField)
            }  else {
                layer.borderColor = selectedBorderColor.cgColor
                layer.borderWidth = dpOTPView.selectedBorderWidthTextField
            }
        } else {
            if dpOTPView.isBottomLineTextField {
                removePreviouslyAddedLayer(name: "bottomBorderLayer")
            }  else {
                layer.borderColor = nil
                layer.borderWidth = 0
            }
        }
    }
    
    fileprivate func addUnselectedBorderColor() {
        if let unselectedBorderColor = dpOTPView.borderColorTextField {
            if dpOTPView.isBottomLineTextField {
                addBottomLine(unselectedBorderColor, width: dpOTPView.borderWidthTextField)
            }  else {
                layer.borderColor = unselectedBorderColor.cgColor
                layer.borderWidth = dpOTPView.borderWidthTextField
            }
        }  else {
            if dpOTPView.isBottomLineTextField {
                removePreviouslyAddedLayer(name: "bottomBorderLayer")
            }  else {
                layer.borderColor = nil
                layer.borderWidth = 0
            }
        }
    }
    
    fileprivate func addBottomLine(_ color : UIColor , width : CGFloat) {
        let border = CALayer()
        border.name = "bottomBorderLayer"
        removePreviouslyAddedLayer(name: border.name ?? "")
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.width - width ,width : self.frame.width ,height: width)
        self.layer.addSublayer(border)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: dpOTPView.textEdgeInsets ?? UIEdgeInsets.zero)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: dpOTPView.editingTextEdgeInsets ?? UIEdgeInsets.zero)
    }
    
    fileprivate func removePreviouslyAddedLayer(name : String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
}


fileprivate extension String {
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
}
