//
//  ViewController.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by kingjiajie on 11/18/2019.
//  Copyright (c) 2019 kingjiajie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var myTableView : UITableView = {
        let tableview = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 100.0, height: 100.0), style: UITableView.Style.plain)
        tableview.translatesAutoresizingMaskIntoConstraints = false;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tableFooterView = UIView();
        return tableview
    }()
    let myTitleArr : Array = ["CollectionView（包住section圆角）",//1
                              "有Header&Footer，包Header,不包Footer",//2
                              "有Header&Footer，包Header,包Footer",//3
                              "有Header&Footer，不包Header,包Footer",//4
                              "CollectionView（包住section圆角）(横向)",//5
                              "CollectionView (横向 有H&F View)",//6
                              "borderLine 包Section",//7
                              "borderLine 包Section（带投影）",//8
                              "BackgroundColor 底色（带投影）",//9
                              "CollectionView（底色 圆角 分别不同颜色）",//10
                              "CollectionView（单独设置某个 header 底色）",
                              "CollectionView（单独设置某个 footer 底色））",
                              "CollectionView,无sections底色，cell左对齐",
                              "CollectionView,有sections底色，cell左对齐"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialization()
    }
    
    func initialization() {
        self.navigationItem.title = "JJCollectionViewRoundFlowLayout_Swift";
        self.initSetup();
        self.initLayout();
    }
    
    func initSetup() {
        
    }
    
    func initLayout() {
        view.addSubview(myTableView)
        let myView = myTableView;
        let superview = self.view;
        
        view.addConstraints([
            //view constraints
            NSLayoutConstraint.init(item: myView,
                                    attribute: .topMargin,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .topMargin,
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
                                    attribute: .bottomMargin,
                                    relatedBy: .equal,
                                    toItem: superview,
                                    attribute: .bottomMargin,
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

extension ViewController : UITableViewDataSource   {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myTitleArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier);
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier);
        }
        cell?.textLabel?.text = self.myTitleArr[indexPath.row];
        return cell!;
    }
}

extension ViewController : UITableViewDelegate   {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = NextViewController.init();
        switch (indexPath.row) {
        case 0:
            VC.isHaveHeaderFooterView = false;
        case 1:
            VC.isHaveHeaderFooterView = true;
            VC.isRoundWithHeaerView = true;
        case 2:
            VC.isHaveHeaderFooterView = true;
            VC.isRoundWithHeaerView = true;
            VC.isRoundWithFooterView = true;
        case 3:
            VC.isHaveHeaderFooterView = true;
            VC.isRoundWithFooterView = true;
        case 4:
            VC.isHaveHeaderFooterView = false;
            VC.isHorizontal = true;
        case 5:
            VC.isHaveHeaderFooterView = true;
            VC.isRoundWithHeaerView = true;
            VC.isRoundWithFooterView = true;
            VC.isHorizontal = true;
        case 6:
            let secondVC = SecondViewController.init();
            secondVC.isHaveShadow = false;
            self.navigationController?.pushViewController(secondVC, animated: true);
            return;
        case 7:
            let secondVC = SecondViewController.init();
            secondVC.isHaveShadow = true;
            self.navigationController?.pushViewController(secondVC, animated: true);
            return
        case 8:
            let secondVC = SecondViewController.init();
            secondVC.isHaveShadow = true;
            secondVC.isHaveBGColor = true;
            self.navigationController?.pushViewController(secondVC, animated: true);
            return
        case 9:
            VC.isHaveHeaderFooterView = false;
            VC.isShowDifferentColor = true;
        case 10:
            let thirdVC = ThirdViewController.init();
            thirdVC.isHaveHeaderFooterView = true;
            thirdVC.isRoundWithHeaerView = true;
            self.navigationController?.pushViewController(thirdVC, animated: true);
            return
        case 11:
            let thirdVC = ThirdViewController.init();
            thirdVC.isHaveHeaderFooterView = true;
            thirdVC.isRoundWithFooterView = true;
            self.navigationController?.pushViewController(thirdVC, animated: true);
            return
        case 12:
            let fourVC = FourViewController.init();
            fourVC.isAlignmentLeft = .Left;
            self.navigationController?.pushViewController(fourVC, animated: true);
            return;
        case 13:
            let fourVC = FourViewController.init();
            fourVC.isAlignmentLeft = .Left;
            fourVC.isHaveRoundBGView = true;
            self.navigationController?.pushViewController(fourVC, animated: true);
            return;
        default:
            break;
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
