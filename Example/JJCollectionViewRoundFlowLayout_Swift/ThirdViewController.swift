//
//  ThirdViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift_Example
//
//  Created by jiajie on 2020/1/2.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class ThirdViewController: UIViewController {
    
    lazy var myCollectionView: UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift.init();
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
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.register(MyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "MyCollectionReusableView")
        collectionView.register(MyCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "MyCollectionReusableView")
        
        
        return collectionView;
    }()
    
    var isHaveHeaderFooterView:Bool = false;
    var isRoundWithHeaerView:Bool = false;
    var isRoundWithFooterView:Bool = false;
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initialization();
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

extension ThirdViewController :UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.labelText.text = "测试内容"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isHaveHeaderFooterView{
            return CGSize.init(width: 100, height: 60);
        }
        return CGSize.init(width: 0, height: 0);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if self.isHaveHeaderFooterView{
            return CGSize.init(width: 100, height: 60);
        }
        return CGSize.init(width: 0, height: 0);
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

extension ThirdViewController :UICollectionViewDelegate {
    
}

extension ThirdViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        model.backgroundColor = UIColor.init(red: 233/255.0, green: 233/255.0, blue: 233/255.0, alpha: 1.0)
        model.cornerRadius = 10;
        return model;
    }
    
    /// 根据section设置是否包含headerview（实现该方法后，isCalculateHeader将不会生效）
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - layout: layout description
    ///   - section: section description
    func collectionView(collectionView: UICollectionView,layout: UICollectionViewLayout, isCalculateHeaderViewIndex section: NSInteger) -> Bool {
        
        if (self.isRoundWithHeaerView) {
            if (section % 2 == 0) {
                return true;
            }
        }else{
            if (section == 0) {
                return true;
            }
        }
        return false;
    }
    
    /// 根据section设置是否包含footerview（实现该方法后，isCalculateFooter将不会生效）
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - layout: layout description
    ///   - section: section description
    func collectionView(collectionView: UICollectionView,layout: UICollectionViewLayout, isCalculateFooterViewIndex section: NSInteger) -> Bool {
        if (self.isRoundWithFooterView) {
            if (section % 2 == 0) {
                return true;
            }
        }else{
            if (section == 0) {
                return true;
            }
        }
        return false;
    }
}
