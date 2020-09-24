//
//  FifthlyViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift_Example
//
//  Created by jiajie on 2020/9/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JJCollectionViewRoundFlowLayout_Swift

class FifthlyViewController: UIViewController {
    
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

extension FifthlyViewController :UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.labelText.text = "测试内容"
        return cell
    }
}


extension FifthlyViewController :UICollectionViewDelegate {
    
}

extension FifthlyViewController : JJCollectionViewDelegateRoundFlowLayout_Swift{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
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
    
    func collectionView(collectionView: UICollectionView, didSelectDecorationViewAtIndexPath indexPath: IndexPath) {
        let message = String.init(format: "section --- %ld \n row --- %ld", indexPath.section,indexPath.row)
        let alert = UIAlertController.init(title: "JJCollectionViewRoundFlowLayout_Swift", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
}

