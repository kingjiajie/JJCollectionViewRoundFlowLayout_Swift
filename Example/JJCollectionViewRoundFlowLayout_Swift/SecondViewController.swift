//
//  SecondViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/17.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class SecondViewController: UIViewController {
    
    lazy var myCollectionView : UICollectionView = {
        let layout = JJCollectionViewRoundFlowLayout_Swift.init();
        //setting
        layout.sectionInset = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20);
        layout.itemSize = CGSize.init(width: 100, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
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
    
    var isHaveShadow :Bool = false
    var isHaveBGColor :Bool = false
    
    
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

extension SecondViewController :UICollectionViewDataSource{
    
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


extension SecondViewController :UICollectionViewDelegate {
    
}

extension SecondViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
        let model = JJCollectionViewRoundConfigModel_Swift.init();
        model.cornerRadius = 4;
        
        if (self.isHaveShadow) {
            if (self.isHaveBGColor) {
                model.backgroundColor = UIColor.init(red: 236/255.0, green:236/255.0 ,blue:236/255.0,alpha:1.0)
                model.shadowColor = UIColor.black.withAlphaComponent(0.6)
            }else{
                model.backgroundColor = UIColor.init(red: 255/255.0, green:255/255.0 ,blue:255/255.0,alpha:1.0)
                model.shadowColor = UIColor.init(red: 204/255.0, green:204/255.0 ,blue:204/255.0,alpha:0.6)
            }
            model.shadowOffset = CGSize.init(width: 0, height: 0)
            model.shadowOpacity = 1;
            model.shadowRadius = 4;
        }else{
            model.borderColor = UIColor.init(red: 204/255.0, green:204/255.0 ,blue:204/255.0,alpha:1.0);
            model.borderWidth = 1.0;
        }
        
        return model;
        
    }
}
