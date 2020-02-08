//
//  JJCollectionViewRoundConfigModel.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/17.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit

@objcMembers
open class JJCollectionViewRoundConfigModel_Swift: NSObject {
    open var borderWidth : CGFloat = 0;
    open var borderColor : UIColor?
    
    open var backgroundColor : UIColor?
    open var shadowColor : UIColor?
    open var shadowOffset : CGSize?
    open var shadowOpacity : Float = 0;
    open var shadowRadius : CGFloat = 0;
    open var cornerRadius : CGFloat = 0;
    
}
