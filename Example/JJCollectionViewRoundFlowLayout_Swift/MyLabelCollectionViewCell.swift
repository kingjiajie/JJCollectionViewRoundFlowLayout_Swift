//
//  MyLabelCollectionViewCell.swift
//  JJCollectionViewRoundFlowLayout_Swift_Example
//
//  Created by jiajie on 2020/2/4.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class MyLabelCollectionViewCell: UICollectionViewCell {
    var labelText : UILabel = {
        let label = UILabel.init();
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.backgroundColor = UIColor.clear;
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        label.font = UIFont.systemFont(ofSize: 15);
        label.textAlignment = .center;
        return label;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialization() {
        self.layer.cornerRadius = 15;
        self.backgroundColor = UIColor.init(red: 250/255.0, green: 185/255.0, blue: 105/255.0, alpha: 1.0);
        initSetup()
        initLayout()
    }
    
    
    func initSetup() {
        
    }
    
    func initLayout() {
        addSubview(labelText)
        addConstraints([
            NSLayoutConstraint.init(item: labelText, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: labelText, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
        ])
    }
}
