//
//  MyCollectionReusableView.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/17.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit

class MyCollectionReusableView: UICollectionReusableView {
    var myLabel : UILabel = {
        let label = UILabel.init()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization();
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialization() {
        initSetup()
        initLayout()
    }
    
    func initSetup() {
        
    }
    
    func initLayout() {
        addSubview(myLabel)
        addConstraints([
            NSLayoutConstraint.init(item: myLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: myLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20),
            NSLayoutConstraint.init(item: myLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0),
            NSLayoutConstraint.init(item: myLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        ])
    }
    
}
