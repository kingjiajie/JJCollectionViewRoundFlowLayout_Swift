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

    
//MARK: - 不规则Cell计算方案
extension JJCollectionViewFlowLayoutUtils_Swift{
    
    /// 不规则cell找出top最高位置
    /// - Parameters:
    ///   - layout: layout description
    ///   - section: section description
    ///   - numberOfItems: numberOfItems description
    ///   - defaultFrame: defaultFrame description
    static func calculateIrregularitiesCellByMinTopFrameWithLayout(_ layout : UICollectionViewFlowLayout,
                                                            section:Int,
                                                            numberOfItems:Int,
                                                            defaultFrame:CGRect) -> CGRect {
        var firstFrame = defaultFrame;
        if layout.scrollDirection == .vertical {
            //竖向
            var minY = firstFrame.minY;
            for i in 0...numberOfItems-1{
                guard let attr = layout.layoutAttributesForItem(at: IndexPath.init(row: i, section: section)) else {
                    continue;
                }
                minY = min(minY, attr.frame.minY);
            }
            let rect = firstFrame;
            firstFrame = CGRect.init(x: rect.origin.x, y: minY, width: rect.size.width, height: rect.size.height)
        }else{
            var minX = firstFrame.minX;
            for i in 0...numberOfItems-1{
                guard let attr = layout.layoutAttributesForItem(at: IndexPath.init(row: i, section: section)) else {
                    continue;
                }
                
                minX = min(minX, attr.frame.minX);
            }
            let rect = firstFrame;
            firstFrame = CGRect.init(x: minX, y: rect.origin.y, width: rect.size.width, height: rect.size.height)
        }
        return firstFrame;
    }
    
    /// 不规则cell找出bootom最低位置
    /// - Parameters:
    ///   - layout: layout description
    ///   - section: section description
    ///   - numberOfItems: numberOfItems description
    ///   - defaultFrame: defaultFrame description
    static func calculateIrregularitiesCellByMaxBottomFrameWithLayout(_ layout : UICollectionViewFlowLayout,
                                                               section : Int,
                                                               numberOfItems : Int,
                                                               defaultFrame : CGRect) -> CGRect {
        var lastFrame = defaultFrame;
        if layout.scrollDirection == .vertical {
            //竖向
            var maxY = lastFrame.maxY;
            var index = numberOfItems-1;
            for i in 0...numberOfItems-1{
                guard let attr = layout.layoutAttributesForItem(at: IndexPath.init(row: i, section: section)) else {
                    continue;
                }
                if maxY < max(maxY, attr.frame.maxY) {
                    maxY = max(maxY, attr.frame.maxY)
                    index = i;
                }
            }
            lastFrame = layout.layoutAttributesForItem(at: IndexPath.init(row: index, section: section))!.frame;
        }else{
            //横向
            var maxX = lastFrame.maxX;
            var index = numberOfItems-1;
            for i in 0...numberOfItems - 1{
                guard let attr = layout.layoutAttributesForItem(at: IndexPath.init(row: i, section: section)) else {
                    continue;
                }
                if maxX < max(maxX, attr.frame.maxX) {
                    maxX = max(maxX, attr.frame.maxX);
                    index = i;
                }
            }
            lastFrame = layout.layoutAttributesForItem(at: IndexPath.init(row: index, section: section))!.frame;
        }
        return lastFrame;
    }
}

