//
//  JJCollectionViewRoundFlowLayout_Swift.swift
//  JJCollectionViewRoundFlowLayout_Swift
//
//  Created by jiajie on 2019/11/16.
//  Copyright © 2019 aihuo. All rights reserved.
//

import UIKit

class JJCollectionReusableView_Swift: UICollectionReusableView {
    
    var myCacheAttr : JJCollectionViewRoundLayoutAttributes_Swift = {
        return JJCollectionViewRoundLayoutAttributes_Swift.init();
    }()
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attr = layoutAttributes as! JJCollectionViewRoundLayoutAttributes_Swift
        myCacheAttr = attr;
        self.toChangeCollectionReusableViewRoundInfo(myCacheAttr);
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        self.toChangeCollectionReusableViewRoundInfo(myCacheAttr);
    }
    
    func toChangeCollectionReusableViewRoundInfo(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        let attr = layoutAttributes as! JJCollectionViewRoundLayoutAttributes_Swift
        if (attr.myConfigModel != nil) {
            let model = attr.myConfigModel!;
            let view = self;
            
            if #available(iOS 13.0, *) {
                view.layer.backgroundColor = model.backgroundColor?.resolvedColor(with: self.traitCollection).cgColor
            } else {
                // Fallback on earlier versions
                view.layer.backgroundColor = model.backgroundColor?.cgColor;
            };
            
            if #available(iOS 13.0, *) {
                view.layer.shadowColor = model.shadowColor?.resolvedColor(with: self.traitCollection).cgColor
            } else {
                // Fallback on earlier versions
                view.layer.shadowColor = model.shadowColor?.cgColor;
            };
            view.layer.shadowOffset = model.shadowOffset ?? CGSize.init(width: 0, height: 0);
            view.layer.shadowOpacity = model.shadowOpacity;
            view.layer.shadowRadius = model.shadowRadius;
            view.layer.cornerRadius = model.cornerRadius;
            view.layer.borderWidth = model.borderWidth;
            
            if #available(iOS 13.0, *) {
                view.layer.borderColor = model.borderColor?.resolvedColor(with: self.traitCollection).cgColor
            } else {
                // Fallback on earlier versions
                view.layer.borderColor = model.borderColor?.cgColor;
            };
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == UIEvent.EventType.touches {
            self.decorationViewUserDidSelectEvent();
        }
    }
    
    func decorationViewUserDidSelectEvent() {
        guard let collectionView = self.superview else {
            return;
        }
        
        if collectionView.isKind(of: UICollectionView.self) {
            let myCollectionView = collectionView as! UICollectionView;
            let delegate = myCollectionView.delegate as! JJCollectionViewDelegateRoundFlowLayout_Swift;
            if delegate.responds(to: #selector(delegate.collectionView(collectionView:didSelectDecorationViewAtIndexPath:))) {
                delegate .collectionView?(collectionView: myCollectionView, didSelectDecorationViewAtIndexPath: myCacheAttr.indexPath);
            }
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
    
    /// 设置底色相关
    /// - Parameter collectionView: collectionView description
    /// - Parameter collectionViewLayout: collectionViewLayout description
    /// - Parameter section: section description
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout , configModelForSectionAtIndex section : Int ) -> JJCollectionViewRoundConfigModel_Swift;
    
    /// 设置底色偏移量(该设置只设置底色，与collectionview原sectioninsets区分）
    /// - Parameter collectionView: collectionView description
    /// - Parameter collectionViewLayout: collectionViewLayout description
    /// - Parameter section: section description
    @objc optional func collectionView(_ collectionView : UICollectionView , layout collectionViewLayout:UICollectionViewLayout,borderEdgeInsertsForSectionAtIndex section : Int) -> UIEdgeInsets;
    
    /// 设置是否计算headerview（根据section判断是否单独计算）
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - layout: layout description
    ///   - section: section description
    @objc optional func collectionView(collectionView:UICollectionView ,layout:UICollectionViewLayout , isCalculateHeaderViewIndex section : NSInteger) -> Bool;
    
    /// 设置是否计算footerview（根据section判断是否单独计算）
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - layout: layout description
    ///   - section: section description
    @objc optional func collectionView(collectionView:UICollectionView , layout:UICollectionViewLayout , isCalculateFooterViewIndex section : NSInteger) -> Bool;
    
    /// 当Cell个数为0时，是否允许进行计算（根据section判断是否单独计算，Cell个数为0时，会检测计算Header或Footer）
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - layout: layout description
    ///   - section: section description
    @objc optional func collectionView(collectionView:UICollectionView , layout:UICollectionViewLayout , isCanCalculateWhenRowEmptyWithSection section : NSInteger) -> Bool;
    
    
    /// 背景图点击事件
    /// - Parameters:
    ///   - collectionView: collectionView description
    ///   - indexPath: 点击背景图的indexPath
    @objc optional func collectionView(collectionView:UICollectionView , didSelectDecorationViewAtIndexPath indexPath:IndexPath);
}

@objcMembers
open class JJCollectionViewRoundFlowLayout_Swift: UICollectionViewFlowLayout {
    
    /// 设置cell对齐方式，不设置为使用系统默认，支持Left
    open var collectionCellAlignmentType : JJCollectionViewRoundFlowLayoutSwiftAlignmentType = .System;

    /// 是否开始Round计算，（默认YES），当该位置为false时，计算模块都不开启，包括设置的代理
    open var isRoundEnabled : Bool = true;
    
    open var isCalculateHeader : Bool = false    // 是否计算header
    open var isCalculateFooter : Bool = false    // 是否计算footer
    
    //是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认false
    open var isCalculateTypeOpenIrregularitiesCell : Bool = false
    
    /**************************************************************************************/
    /// 当Cell个数为0时，是否允许进行计算（开启后，Cell个数为0时，会检测计算Header或Footer）
    /// 注意！！！是否计算Header或Footer，会根据设置的isCalculateHeader、isCalculateFooter和对应代理方法进行判断！！！请注意！！！
    ///（若实现collectionView:layout:isCanCalculateWhenRowEmptyWithSection:）该字段不起作用
    /// 注意！！！！！！ 在使用该功能的时候，请自行检测和处理sectionInset的偏移量，Cell无数据时，有header&footer，设置了的sectionInset还是生效的，底色在计算时候会进行sectionInset相关的偏移处理。
    /**************************************************************************************/
    open var isCanCalculateWhenRowEmpty : Bool = false
    
    //自定义Attr数组
    var decorationViewAttrs : [UICollectionViewLayoutAttributes] = {
        let arr = NSMutableArray.init(capacity: 0)
        return arr as! [UICollectionViewLayoutAttributes]
    }()
}

extension JJCollectionViewRoundFlowLayout_Swift{
    
    override public func prepare() {
        super.prepare()
        
        if !self.isRoundEnabled {
            //为NO，不需要开启时直接return
            return;
        }
        
        guard let sections = collectionView?.numberOfSections else { return };
        let delegate = collectionView?.delegate as! JJCollectionViewDelegateRoundFlowLayout_Swift
        
        //检测是否实现了背景样式模块代理
        if delegate.responds(to: #selector(delegate.collectionView(_:layout:configModelForSectionAtIndex:))) {
            
        }else{
            return;
        }
        
        //init
        self.register(JJCollectionReusableView_Swift.self, forDecorationViewOfKind: JJCollectionViewRoundFlowLayout_Swift.JJCollectionViewRoundSectionSwift)
        decorationViewAttrs.removeAll()
        
        for section in 0..<sections {
            let numberOfItems = collectionView?.numberOfItems(inSection: section);
            
            var firstFrame = CGRect.null;
            if numberOfItems != nil && numberOfItems! > 0  {
                let firstAttr = layoutAttributesForItem(at: IndexPath.init(row: 0, section: section))
                firstFrame = firstAttr!.frame;
            } else if delegate.responds(to: #selector(delegate.collectionView(collectionView:layout:isCanCalculateWhenRowEmptyWithSection:))) {
                //如果没有设置当Cell个数为0时，实现了代理，执行代理方法判断section是否进行计算
                if !delegate.collectionView!(collectionView: self.collectionView!, layout: self, isCanCalculateWhenRowEmptyWithSection: section) {
                    continue;
                }
            }else if(!isCanCalculateWhenRowEmpty) {
                //如果没有设置当Cell个数为0时，进行是否计算的字段
                continue;
            }
                        
            //判断是否计算headerview
            var isCalculateHeaderView = false;
            if delegate.responds(to: #selector(delegate.collectionView(collectionView:layout:isCalculateHeaderViewIndex:))) {
                isCalculateHeaderView = delegate.collectionView!(collectionView: self.collectionView!, layout: self, isCalculateHeaderViewIndex: section);
            }else{
                isCalculateHeaderView = self.isCalculateHeader;
            }
            
            if isCalculateHeaderView {
                //headerView
                let headerAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(row: 0, section: section))
                if headerAttr != nil &&
                    (headerAttr?.frame.size.width != 0 ||
                     headerAttr?.frame.size.height != 0) {
                    firstFrame = headerAttr!.frame;
                }else{
                    var rect = firstFrame;
                    if !rect.isNull {
                        if isCalculateTypeOpenIrregularitiesCell {
                            rect = JJCollectionViewFlowLayoutUtils_Swift.calculateIrregularitiesCellByMinTopFrameWithLayout(self, section: section, numberOfItems: numberOfItems!, defaultFrame: rect);
                        }
                        
                        firstFrame = self.scrollDirection == .vertical ?
                            CGRect.init(x: rect.origin.x,
                                        y: rect.origin.y,
                                        width: collectionView!.bounds.size.width,
                                        height: rect.size.height):
                            CGRect.init(x: rect.origin.x,
                                        y: rect.origin.y,
                                        width: rect.size.width,
                                        height: collectionView!.bounds.size.height);
                    }
                }
            }else{
                //不计算headerview的情况
                if isCalculateTypeOpenIrregularitiesCell {
                    if !firstFrame.isNull {
                        firstFrame = JJCollectionViewFlowLayoutUtils_Swift.calculateIrregularitiesCellByMinTopFrameWithLayout(self, section: section, numberOfItems: numberOfItems!, defaultFrame: firstFrame);
                    }
                }
            }
            
            var lastFrame = CGRect.null;
            if numberOfItems != nil && numberOfItems! > 0  {
                let lastAttr = layoutAttributesForItem(at: IndexPath.init(row:(numberOfItems! - 1), section: section))
                lastFrame = lastAttr!.frame;
            }
            
            //判断是否计算headerview
            var isCalculateFooterView = false;
            if delegate.responds(to: #selector(delegate.collectionView(collectionView:layout:isCalculateFooterViewIndex:))) {
                isCalculateFooterView = delegate.collectionView!(collectionView: self.collectionView!, layout: self, isCalculateFooterViewIndex: section);
            }else{
                isCalculateFooterView = self.isCalculateFooter;
            }
            
            if isCalculateFooterView {
                //footerView
                let footerAttr = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: IndexPath.init(row: 0, section: section))
                if footerAttr != nil &&
                    (footerAttr?.frame.size.width != 0 ||
                     footerAttr?.frame.size.height != 0) {
                    lastFrame = footerAttr!.frame;
                }else{
                    var rect = lastFrame;
                    if !rect.isNull {
                        if self.isCalculateTypeOpenIrregularitiesCell {
                            rect = JJCollectionViewFlowLayoutUtils_Swift.calculateIrregularitiesCellByMaxBottomFrameWithLayout(self, section: section, numberOfItems: numberOfItems!, defaultFrame: rect);
                        }
                        lastFrame = self.scrollDirection == .vertical ?
                            CGRect.init(x: rect.origin.x,
                                        y: rect.origin.y,
                                        width: collectionView!.bounds.size.width,
                                        height: rect.size.height):
                            CGRect.init(x: rect.origin.x,
                                        y: rect.origin.y,
                                        width: rect.size.width,
                                        height: collectionView!.bounds.size.height)
                    }
                }
            }else{
                //不计算footerView的情况
                if self.isCalculateTypeOpenIrregularitiesCell {
                    if !lastFrame.isNull {
                        lastFrame = JJCollectionViewFlowLayoutUtils_Swift.calculateIrregularitiesCellByMaxBottomFrameWithLayout(self, section: section, numberOfItems: numberOfItems!, defaultFrame: lastFrame);
                    }
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
                userCustomSectionInset = delegate.collectionView!(self.collectionView!, layout: self, borderEdgeInsertsForSectionAtIndex: section)
            }
            
            var sectionFrame = CGRect.null;
            if !firstFrame.isNull && !lastFrame.isNull {
                sectionFrame = firstFrame.union(lastFrame);
            }else if(!firstFrame.isNull) {
                sectionFrame = firstFrame.union(firstFrame);
            }else if(!lastFrame.isNull) {
                sectionFrame = lastFrame.union(lastFrame);
            }
                
            if sectionFrame.isNull {
                continue;
            }
            
            if !isCalculateHeaderView && !isCalculateFooterView{
                //都没有headerView&footerView
                sectionFrame = self.calculateDefaultFrameWithSectionFrame(sectionFrame, sectionInset: sectionInset)
            }else{
                if (isCalculateHeaderView && !isCalculateFooterView) {
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
                }else if(!isCalculateHeaderView && isCalculateFooterView){
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
            sectionFrame.origin.x = 0 ;
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
        
        //用户设置了对称方式，进行对称设置 (若没设置，不执行，继续其他计算)
        if self.collectionCellAlignmentType != .System
        && self.scrollDirection == .vertical{
            //竖向,Cell对齐方式暂不支持横向
            let formatGroudAttr = self.groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs(attrs); //竖向
            
            _ = self.evaluatedAllCellSettingFrameWithLayoutAttributesAttrs(formatGroudAttr, toChangeAttributesAttrsList: &attrs, cellAlignmentType: self.collectionCellAlignmentType)
        }
        
        for attr in self.decorationViewAttrs {
            attrs.append(attr);
        }
        return attrs
    }
}
