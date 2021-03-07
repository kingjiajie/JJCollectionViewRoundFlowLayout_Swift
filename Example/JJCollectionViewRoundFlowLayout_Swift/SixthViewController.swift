//
//  SixthViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift_Example
//
//  Created by jiajie on 2021/3/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class SixthViewController: UIViewController {
    
    lazy var myCollectionView : UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift.init();
        //setting
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0);
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        layout.isCalculateHeader = self.isRoundWithHeaerView;
        layout.isCalculateFooter = self.isRoundWithFooterView;
        
        //init
        let collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: 100.0, height: 100.0), collectionViewLayout: layout);
        collectionView.translatesAutoresizingMaskIntoConstraints = false;
        collectionView.delegate = self;
        collectionView.dataSource = self;

        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.register(MyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCollectionReusableView")
        collectionView.register(MyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "MyCollectionReusableView")
        
        return collectionView;
    }()
    
    var isHaveHeaderFooterView :Bool = false
    var isRoundWithHeaerView :Bool = false
    var isRoundWithFooterView :Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialization()
    }
    
    func initialization() {
        self.navigationItem.title = "JJCollectionViewRoundFlowLayout_Swift";
        self.view.backgroundColor = UIColor.init(white: 1.0, alpha: 1.0)
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

extension SixthViewController :UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.labelText.text = "测试内容"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MyCollectionReusableView", for: indexPath) as! MyCollectionReusableView
        if kind == UICollectionElementKindSectionHeader {
            view.myLabel.text = "Header";
            return view;
        }else{
            view.myLabel.text = "Footer";
            return view;
        }
    }
}


extension SixthViewController :UICollectionViewDelegate {
    
}

extension SixthViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard self.isHaveHeaderFooterView else {
            return CGSize.init(width: 0, height: 0)
        }
        return CGSize.init(width: 100, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard self.isHaveHeaderFooterView else {
            return CGSize.init(width: 0, height: 0)
        }
        return CGSize.init(width: 100, height: 60)
    }
    
    //测试不规则Cell
//    func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
//        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0 {
//            return CGSize.init(width: self.randomIntNumber(lower: 40, upper: 50), height: self.randomIntNumber(lower: 30, upper: 50))
//        }else if indexPath.row == 11{
//            return CGSize.init(width: self.randomIntNumber(lower: 40, upper: 50), height: self.randomIntNumber(lower: 30, upper: 50))
//        }
//        return CGSize.init(width: self.randomIntNumber(lower: 50, upper: 100), height: self.randomIntNumber(lower: 50, upper: 100))
//    }
}

extension SixthViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        
        
        if #available(iOS 13.0, *) {
            model.backgroundColor = UIColor.init { (traitCollection:UITraitCollection) -> UIColor in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.black : UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0);
            }
        } else {
            // Fallback on earlier versions
            model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
        }
        
        model.cornerRadius = 10;
        
        return model;
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, isCalculateHeaderViewIndex section: NSInteger) -> Bool {
        return true;
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, isCalculateFooterViewIndex section: NSInteger) -> Bool {
        return true;
    }
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, isCanCalculateWhenRowEmptyWithSection section: NSInteger) -> Bool {
        if section % 2 == 0 {
            return true;
        }
        return false;
    }
}

