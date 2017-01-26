//
//  ContentCell.swift
//  DialogViewer2
//
//  Created by wanghuiyong on 26/01/2017.
//  Copyright © 2017 Personal Organization. All rights reserved.
//

import UIKit

class ContentCell: UICollectionViewCell {
    var label: UILabel!
    var text: String! {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
            
            var newLabelFrame = label.frame
            var newContentFrame = contentView.frame
            
            let textSize = type(of: self).sizeForContentString(str: newText, forMaxWidth: maxWidth)
            newLabelFrame.size = textSize
            newContentFrame.size = textSize
            
            label.frame = newLabelFrame
            contentView.frame = newContentFrame
        }
    }
    var maxWidth: CGFloat!
    
    class func sizeForContentString(str: String, forMaxWidth: CGFloat) -> CGSize {
        let maxSize = CGSize.init(width: forMaxWidth, height: 1000)
        let opt = NSStringDrawingOptions.usesLineFragmentOrigin
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.byCharWrapping
        let attributes = [NSFontAttributeName: self.defaultFont(), NSParagraphStyleAttributeName: style]
        let string = str as NSString
        let rect = string.boundingRect(with: maxSize, options: opt, attributes: attributes, context: nil)
        
        return rect.size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel(frame: self.contentView.bounds)
        label.isOpaque = false
        label.backgroundColor = UIColor.init(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = type(of: self).defaultFont()
        contentView.addSubview(label)		// 注意是内容视图
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    class func defaultFont() -> UIFont {
        return UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    }
}
