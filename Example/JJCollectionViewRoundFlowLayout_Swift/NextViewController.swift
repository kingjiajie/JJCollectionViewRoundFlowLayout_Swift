//
//  NextViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/17.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class NextViewController: UIViewController {
    
    lazy var myCollectionView : UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift.init();
        //setting
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20);
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        layout.scrollDirection = self.isHorizontal ? UICollectionView.ScrollDirection.horizontal : UICollectionView.ScrollDirection.vertical;
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
    var isHorizontal :Bool = false
    var isShowDifferentColor :Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialization()
    }
    
    func initialization() {
        self.navigationController?.title = "JJCollectionViewRoundFlowLayout_Swift";
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

extension NextViewController :UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12;
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


extension NextViewController :UICollectionViewDelegate {
    
}

extension NextViewController : UICollectionViewDelegateFlowLayout{
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
}

extension NextViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        
        model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
        model.cornerRadius = 10;
        
        if (self.isShowDifferentColor) {
            if (section == 0) {
                model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0);
            }else{
                model.backgroundColor = UIColor.init(red: 100/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0);
            }
        }
        
        return model;
        
    }
}

