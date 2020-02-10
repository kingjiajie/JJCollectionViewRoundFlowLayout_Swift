//
//  FourViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift_Example
//
//  Created by jiajie on 2020/2/3.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class FourViewController: UIViewController {
    
    var isHaveRoundBGView:Bool = false;
    var myAlignmentType:JJCollectionViewRoundFlowLayoutSwiftAlignmentType = .System;
    
    lazy var myCollectionView : UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift.init();
        
        layout.collectionCellAlignmentType = self.myAlignmentType;
        layout.isRoundEnabled = self.isHaveRoundBGView;
        
        
        //setting
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20);
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        //init
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
        collectionView.register(MyLabelCollectionViewCell.self, forCellWithReuseIdentifier: "MyLabelCollectionViewCell")
        
        return collectionView;
    }();
    
    let myDataArr : Array = ["Hello",
                             "你好",
                             "您好啊。",
                             "大家好，这里是JJCollectionView",
                             "标签",
                             "对应不错的东西哦",
                             "GitHub",
                             "支持左对齐方式",
                             "这个东西就是很长，就想弄一个很长的出来",
                             "上面的文字好像不够长",
                             "想一下接下来做什么功能呢",
                             "嗯，知道了",
                             "优秀"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.initialization();
    }
    deinit {
        
    }
    
    func initialization() {
        self.initSetup();
        self.initLayout();
    }
    
    func initSetup() {
        
    }
    
    func initLayout() {
        view.addSubview(myCollectionView)
        let myView = myCollectionView;
        let superview = self.view;
        
        view.addConstraints([
            //view constraints
            NSLayoutConstraint.init(item: myView,
                                    attribute: .top,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .top,
                                    multiplier: 1.0,
                                    constant: 0),
            NSLayoutConstraint.init(item: myView,
                                    attribute: .leading,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .leading,
                                    multiplier: 1.0,
                                    constant: 0),
            NSLayoutConstraint.init(item: myView,
                                    attribute: .bottom,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .bottom,
                                    multiplier: 1.0,
                                    constant: 0),
            NSLayoutConstraint.init(item: myView,
                                    attribute: .trailing,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .trailing,
                                    multiplier: 1.0,
                                    constant: 0),
            
        ]);
    }
}

extension FourViewController{
    
    static func calculateStringViewSizeWithShowSize(_ showSize : CGSize , fontSize : UIFont , string : String) -> CGSize {
        let size = showSize;
        
        let dic = [NSAttributedStringKey.font:fontSize];
        let stringDrawingOptions = NSStringDrawingOptions.init(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue
            | NSStringDrawingOptions.usesFontLeading.rawValue);
        let cur = ((string as NSString).boundingRect(with: size, options: stringDrawingOptions, attributes: dic, context: nil)).size;
        return cur;
    }
}

extension FourViewController :UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myDataArr.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyLabelCollectionViewCell", for: indexPath) as! MyLabelCollectionViewCell
        cell.labelText.text = self.myDataArr[indexPath.row];
        return cell
    }
}

extension FourViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = self.myDataArr[indexPath.row];
        
        let size = FourViewController.calculateStringViewSizeWithShowSize(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 38), fontSize: UIFont.systemFont(ofSize: 15), string: string);
        return CGSize.init(width: size.width + 10 + 1, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
}

extension FourViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        model.backgroundColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
        model.cornerRadius = 10;
        return model;
    }
}
