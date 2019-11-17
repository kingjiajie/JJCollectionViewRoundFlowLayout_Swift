//
//  JJCollectionViewRoundFlowLayout_Swift.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/16.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit

class JJCollectionReusableView_Swift: UICollectionReusableView {
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attr = layoutAttributes as! JJCollectionViewRoundLayoutAttributes_Swift
        if (attr.myConfigModel != nil) {
            let model = attr.myConfigModel!;
            let view = self;
            view.layer.backgroundColor = model.backgroundColor?.cgColor;
            view.layer.shadowColor = model.shadowColor?.cgColor;
            view.layer.shadowOffset = model.shadowOffset ?? CGSize.init(width: 0, height: 0);
            view.layer.shadowOpacity = model.shadowOpacity;
            view.layer.shadowRadius = model.shadowRadius;
            view.layer.cornerRadius = model.cornerRadius;
            view.layer.borderWidth = model.borderWidth;
            view.layer.borderColor = model.borderColor?.cgColor;
        }
    }
}

class JJCollectionViewRoundLayoutAttributes_Swift: UICollectionViewLayoutAttributes {
    var borderEdgeInsets : UIEdgeInsets?
    var myConfigModel : JJCollectionViewRoundConfigModel_Swift?
}

extension JJCollectionViewRoundFlowLayout_Swift{
    public static let JJCollectionViewRoundSectionSwift: String = "com.JJCollectionViewRoundSectionSwift"
}

@objc public protocol JJCollectionViewDelegateRoundFlowLayout_Swift : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView : UICollectionView , layout collectionViewLayout:UICollectionViewLayout,borderEdgeInsertsForSectionAtIndex section : Int) -> UIEdgeInsets;
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout , configModelForSectionAtIndex section : Int ) -> JJCollectionViewRoundConfigModel_Swift;
}

open class JJCollectionViewRoundFlowLayout_Swift: UICollectionViewFlowLayout {
    open var isCalculateHeader : Bool = false    // 是否计算header
    open var isCalculateFooter : Bool = false    // 是否计算footer
    
    var decorationViewAttrs : [UICollectionViewLayoutAttributes] = {
        let arr = NSMutableArray.init(capacity: 0)
        return arr as! [UICollectionViewLayoutAttributes]
    }()
}

extension JJCollectionViewRoundFlowLayout_Swift{
    
    override public func prepare() {
        super.prepare()
        
        guard let sections = collectionView?.numberOfSections else { return };
        let delegate = collectionView?.delegate as! JJCollectionViewDelegateRoundFlowLayout_Swift
        
        if (delegate.responds(to: #selector(delegate.collectionView(_:layout:borderEdgeInsertsForSectionAtIndex:))) ||
            delegate.responds(to: #selector(delegate.collectionView(_:layout:configModelForSectionAtIndex:)))){
        }
        else {
            return
        }
        
        //init
        self.register(JJCollectionReusableView_Swift.self, forDecorationViewOfKind: JJCollectionViewRoundFlowLayout_Swift.JJCollectionViewRoundSectionSwift)
        
        decorationViewAttrs.removeAll()
        
        for section in 0..<sections {
            let numberOfItems = collectionView?.numberOfItems(inSection: section);
            if numberOfItems != nil && numberOfItems! > 0 {
                var firstAttr = layoutAttributesForItem(at: IndexPath.init(row: 0, section: section))
                if isCalculateHeader {
                    let headerAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(row: 0, section: section))
                    if headerAttr != nil &&
                        (headerAttr?.frame.size.width != 0 ||
                            headerAttr?.frame.size.height != 0){
                        firstAttr = headerAttr!;
                    }else{
                        let rect = firstAttr!.frame;
                        firstAttr?.frame = CGRect.init(x: rect.origin.x,
                                                       y: rect.origin.y,
                                                       width: collectionView!.bounds.size.width,
                                                       height: collectionView!.bounds.size.height)
                    }
                }
                
                var lastAttr = layoutAttributesForItem(at: IndexPath.init(row:(numberOfItems! - 1), section: section))
                if isCalculateFooter {
                    let footerAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(row: 0, section: section))
                    if footerAttr != nil ||
                        (footerAttr?.frame.size.width != 0 ||
                            footerAttr?.frame.size.height != 0){
                        lastAttr = footerAttr
                    }else{
                        let rect = lastAttr!.frame
                        lastAttr?.frame = CGRect.init(x: rect.origin.x,
                                                      y: rect.origin.y,
                                                      width: collectionView!.bounds.size.width,
                                                      height: collectionView!.bounds.size.height)
                    }
                }
                
                //获取sectionInset
                var sectionInset = self.sectionInset
                if (delegate.responds(to: #selector(delegate.collectionView(_:layout:insetForSectionAt:)))) {
                    let inset = delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAt: section)
                    
                    if inset != sectionInset {
                        sectionInset = inset
                    }
                }
                
                var userCustomSectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                if delegate.responds(to: #selector(delegate.collectionView(_:layout:borderEdgeInsertsForSectionAtIndex:))) {
                    //检测是否实现了该方法，进行赋值
                    userCustomSectionInset = delegate.collectionView(self.collectionView!, layout: self, borderEdgeInsertsForSectionAtIndex: section)
                }
                
                var sectionFrame = firstAttr!.frame.union(lastAttr!.frame)
                if !self.isCalculateHeader && !self.isCalculateFooter{
                    //都没有headerView&footerView
                    sectionFrame = self.calculateDefaultFrameWithSectionFrame(sectionFrame, sectionInset: sectionInset)
                }else{
                    if (self.isCalculateHeader && !self.isCalculateFooter) {
                        //headerView
                        let headerAttr = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(row: 0, section: section))
                        //判断是否有headerview
                        if headerAttr != nil &&
                            (headerAttr?.frame.size.width != 0 || headerAttr?.frame.size.height != 0){
                            if self.scrollDirection == UICollectionView.ScrollDirection.horizontal {
                                //判断包含headerview, left位置已经计算在内，不需要补偏移
                                sectionFrame.size.width += sectionInset.right
                                
                                //减去系统adjustInset的top
                                if #available(iOS 11.0, *) {
                                    sectionFrame.size.height = self.collectionView!.frame.size.height - self.collectionView!.adjustedContentInset.top
                                }else{
                                    sectionFrame.size.height = self.collectionView!.frame.size.height - abs(self.collectionView!.contentOffset.y)/*适配iOS11以下*/;
                                }
                            }else{
                                //判断包含headerview, top位置已经计算在内，不需要补偏移
                                sectionFrame.size.height += sectionInset.bottom;
                            }
                        }else{
                            sectionFrame = self.calculateDefaultFrameWithSectionFrame(sectionFrame, sectionInset: sectionInset)
                        }
                    }else if(!self.isCalculateHeader && self.isCalculateFooter){
                        //footerView
                        let footerAttr = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(row: 0, section: section))
                        if footerAttr != nil &&
                            (footerAttr?.frame.size.width != 0 || footerAttr?.frame.size.height != 0) {
                            if self.scrollDirection == UICollectionView.ScrollDirection.horizontal {
                                //判断包含footerView, right位置已经计算在内，不需要补偏移
                                //(需要补充x偏移)
                                sectionFrame.origin.x -= sectionInset.left;
                                sectionFrame.size.width += sectionInset.left;
                                
                                //减去系统adjustInset的top
                                if #available(iOS 11.0, *) {
                                    sectionFrame.size.height = self.collectionView!.frame.size.height - self.collectionView!.adjustedContentInset.top
                                }else{
                                    sectionFrame.size.height = self.collectionView!.frame.size.height - abs(self.collectionView!.contentOffset.y)/*适配iOS11以下*/;
                                }
                            }else{
                                //判断包含footerView, bottom位置已经计算在内，不需要补偏移
                                //(需要补充y偏移)
                                sectionFrame.origin.y -= sectionInset.top
                                sectionFrame.size.width = self.collectionView!.frame.size.width
                                sectionFrame.size.height += sectionInset.top
                            }
                        }else{
                            sectionFrame = self.calculateDefaultFrameWithSectionFrame(sectionFrame, sectionInset: sectionInset);
                        }
                    }else{
                        //headerView
                        let headerAttr = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(row: 0, section: section))
                        
                        //footerView
                        let footerAttr = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(row: 0, section: section))
                        
                        if headerAttr != nil &&
                            footerAttr != nil &&
                            (headerAttr?.frame.size.width != 0 || headerAttr?.frame.size.height != 0) &&
                            (footerAttr?.frame.size.width != 0 || footerAttr?.frame.size.height != 0){
                            //都有headerview和footerview就不用计算了
                        }else{
                            sectionFrame = self.calculateDefaultFrameWithSectionFrame(sectionFrame, sectionInset: sectionInset);
                        }
                    }
                }
                
                sectionFrame.origin.x += userCustomSectionInset.left;
                sectionFrame.origin.y += userCustomSectionInset.top;
                if self.scrollDirection == UICollectionView.ScrollDirection.horizontal {
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }else{
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }
                
                //2. 定义
                let attr = JJCollectionViewRoundLayoutAttributes_Swift.init(forDecorationViewOfKind:JJCollectionViewRoundFlowLayout_Swift.JJCollectionViewRoundSectionSwift, with: IndexPath.init(row: 0, section: section))
                attr.frame = sectionFrame
                attr.zIndex = -1
                attr.borderEdgeInsets = userCustomSectionInset
                if delegate.responds(to: #selector(delegate.collectionView(_:layout:configModelForSectionAtIndex:))) {
                    attr.myConfigModel = delegate.collectionView(self.collectionView!, layout: self, configModelForSectionAtIndex: section)
                }
                self.decorationViewAttrs.append(attr)
                
            }else{
                continue;
            }
        }
    }
    
}

//MARK: 默认section无偏移大小
extension JJCollectionViewRoundFlowLayout_Swift{
    func calculateDefaultFrameWithSectionFrame(_ frame:CGRect ,sectionInset:UIEdgeInsets) -> CGRect{
        var sectionFrame = frame;
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        if (self.scrollDirection == UICollectionView.ScrollDirection.horizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            //减去系统adjustInset的top
            if #available(iOS 11, *) {
                sectionFrame.size.height = self.collectionView!.frame.size.height - self.collectionView!.adjustedContentInset.top;
            } else {
                sectionFrame.size.height = self.collectionView!.frame.size.height - abs(self.collectionView!.contentOffset.y)/*适配iOS11以下*/;
            }
        }else{
            sectionFrame.size.width = self.collectionView!.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        return sectionFrame;
    }
}

//MARK: --
public extension JJCollectionViewRoundFlowLayout_Swift{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect) ?? []
        for attr in self.decorationViewAttrs {
            attrs.append(attr)
        }
        return attrs
    }
}
