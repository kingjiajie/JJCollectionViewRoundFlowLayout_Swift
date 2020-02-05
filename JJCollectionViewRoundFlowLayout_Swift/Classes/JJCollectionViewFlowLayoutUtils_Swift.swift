//
//  JJCollectionViewFlowLayoutUtils_Swift.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2020/2/4.
//

import UIKit

 class JJCollectionViewFlowLayoutUtils_Swift: NSObject {
    
    /// 获取cell间距
    /// - Parameters:
    ///   - layout: layout description
    ///   - sectionIndex: sectionIndex description
    static func evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout(_ layout:UICollectionViewFlowLayout, atIndex sectionIndex:Int) -> CGFloat{
        var minimumInteritemSpacing = layout.minimumInteritemSpacing;
        
        guard let delegate = layout.collectionView?.delegate else { return minimumInteritemSpacing;}
        
        if delegate.responds(to: #selector((delegate as! UICollectionViewDelegateFlowLayout).collectionView(_:layout:minimumInteritemSpacingForSectionAt:))) {
            minimumInteritemSpacing = (delegate as! UICollectionViewDelegateFlowLayout).collectionView!(layout.collectionView!, layout: layout, minimumInteritemSpacingForSectionAt: sectionIndex);
        }
        return minimumInteritemSpacing;
    }
    
    static func evaluatedSectionInsetForItemWithCollectionLayout(_ layout:UICollectionViewFlowLayout, atIndex index:Int) -> UIEdgeInsets {
        var sectionInset = layout.sectionInset;
        guard let delegate = layout.collectionView?.delegate else { return sectionInset;}
        
        if delegate.responds(to: #selector((delegate as! UICollectionViewDelegateFlowLayout).collectionView(_:layout:insetForSectionAt:))) {
            sectionInset = (delegate as! UICollectionViewDelegateFlowLayout).collectionView!(layout.collectionView!, layout: layout, insetForSectionAt: index);
        }
        return sectionInset;
    }
}
