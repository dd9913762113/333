//
//  CommonTextView.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import UIKit

class CommonTextView: UITextView {

    public var placeholder: NSString? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var placeholderColor: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange(_:)), name: UITextView.textDidChangeNotification, object: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard text.count == 0 else { return }
        let attr = [NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor : placeholderColor]
        let width = bounds.size.width - textContainerInset.left - textContainerInset.right
        let height = bounds.size.height - textContainerInset.top - textContainerInset.bottom
        placeholder?.draw(in: CGRect(x: textContainerInset.left + 4, y: textContainerInset.top, width: width, height: height), withAttributes: attr)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - private
private extension CommonTextView {
    
    @objc func handleTextDidChange(_ noti: Notification) {
        setNeedsDisplay()
    }
    
}
