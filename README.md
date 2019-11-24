# JJCollectionViewRoundFlowLayout_Swift

[![CI Status](https://img.shields.io/travis/kingjiajie/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://travis-ci.org/kingjiajie/JJCollectionViewRoundFlowLayout_Swift)
[![Version](https://img.shields.io/cocoapods/v/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)
[![License](https://img.shields.io/cocoapods/l/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)
[![Platform](https://img.shields.io/cocoapods/p/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)


 JJCollectionViewRoundFlowLayout_Swift是JJCollectionViewRoundFlowLayout（OC：https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout ） 的Swift版本，JJCollectionViewRoundFlowLayout可设置CollectionView的BackgroundColor，可根据用户Cell个数计算背景图尺寸，可自定义是否包括计算CollectionViewHeaderView、CollectionViewFootererView或只计算Cells。设置简单，可自定义背景颜色偏移，设置显示方向（竖向、横向）显示,不同Section设置不同的背景颜色。
   可设置内容：  
   1、collectionView section底色。
   2、是否包含headerview。
   3、是否包含footerview。
   4、支持borderWidth、borderColor。
   5、支持shadow投影。
   6、支持collectionView，Vertical，Horizontal。
   7、支持根据不同section分别设置不同底色显示。  
   
   
   Swift版本地址：[GitHub地址](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift)
   
   OC版本地址：[GitHub地址](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout)
   
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 8.0
* Swift 4.2


## Installation

JJCollectionViewRoundFlowLayout_Swift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:  


```ruby
pod 'JJCollectionViewRoundFlowLayout_Swift'
```

## Overview

![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/show_video.gif)

## Usage

### Import

``` swift
@import JJCollectionViewRoundFlowLayout_Swift;
```

### Enable

``` swift
//可选设置
open var isCalculateHeader : Bool = false    // 是否计算header
open var isCalculateFooter : Bool = false    // 是否计算footer
```

``` swift

/// 设置底色偏移量(该设置只设置底色，与collectionview原sectioninsets区分）
/// - Parameter collectionView: collectionView description
/// - Parameter collectionViewLayout: collectionViewLayout description
/// - Parameter section: section description
func collectionView(_ collectionView : UICollectionView , layout collectionViewLayout:UICollectionViewLayout,borderEdgeInsertsForSectionAtIndex section : Int) -> UIEdgeInsets;

/// 设置底色相关
/// - Parameter collectionView: collectionView description
/// - Parameter collectionViewLayout: collectionViewLayout description
/// - Parameter section: section description
func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout , configModelForSectionAtIndex section : Int ) -> JJCollectionViewRoundConfigModel_Swift;

```

### Example

``` swift

#pragma mark - JJCollectionViewDelegateRoundFlowLayout

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, borderEdgeInsertsForSectionAtIndex section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.init(top: 5, left: 12, bottom: 5, right: 12)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
    let model = JJCollectionViewRoundConfigModel_Swift.init();
    
    model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    model.cornerRadius = 10;
    return model;
}

```

### Setting
#### collectionView section底色
  
  
![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/1.png)

``` swift

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
    let model = JJCollectionViewRoundConfigModel_Swift.init();
    
    model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    model.cornerRadius = 10;
    return model;
}

```  


#### 包含headerview、包含footerview
  
  
![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/2.png)

``` swift

let layout = JJCollectionViewRoundFlowLayout_Swift.init();
layout.isCalculateHeader = self.isRoundWithHeaerView;
layout.isCalculateFooter = self.isRoundWithFooterView;

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
    let model = JJCollectionViewRoundConfigModel_Swift.init();
    
    model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    model.cornerRadius = 10;
    return model;
}

```  


#### 支持collectionView，Vertical，Horizontal
  
  
![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/3.png)


``` swift
//显示方向不需要进行另外设置，根据CollectionView设置好的方面，底色自动进行检测判断。

```  
  
  
#### 支持shadow投影
  
![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/4.png)

``` swift

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
    let model = JJCollectionViewRoundConfigModel_Swift.init();
    model.cornerRadius = 4;
    

    model.backgroundColor = UIColor.init(red: 255/255.0, green:255/255.0 ,blue:255/255.0,alpha:1.0)
    model.shadowColor = UIColor.init(red: 204/255.0, green:204/255.0 ,blue:204/255.0,alpha:0.6)
    model.shadowOffset = CGSize.init(width: 0, height: 0)
    model.shadowOpacity = 1;
    model.shadowRadius = 4;
    return model;
}


```  


#### 支持根据不同section分别设置不同底色显示
  
![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/5.png)
  
  
``` swift

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, configModelForSectionAtIndex section: Int) -> JJCollectionViewRoundConfigModel_Swift {
    let model = JJCollectionViewRoundConfigModel_Swift.init();
    model.cornerRadius = 10
    model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    if (section == 0) {
        model.backgroundColor = UIColor.init(red: 233/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    }else if(section == 1){
        model.backgroundColor =UIColor.init(red: 100/255.0, green:233/255.0 ,blue:233/255.0,alpha:1.0)
    }else{
        //...
    }
    
    return model;
}



```  

## Author

kingjiajie, kingjiajie@sian.com

## License

JJCollectionViewRoundFlowLayout_Swift is available under the MIT license. See the LICENSE file for more info.
