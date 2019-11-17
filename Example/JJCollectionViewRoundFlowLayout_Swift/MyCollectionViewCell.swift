//
//  MyCollectionViewCell.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/17.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    var labelText : UILabel = {
        let label = UILabel.init();
        label.translatesAutoresizingMaskIntoConstraints = false
        
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
