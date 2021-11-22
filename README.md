# JJCollectionViewRoundFlowLayout_Swift

[![CI Status](https://img.shields.io/travis/kingjiajie/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://travis-ci.org/kingjiajie/JJCollectionViewRoundFlowLayout_Swift)
[![Version](https://img.shields.io/cocoapods/v/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)
[![License](https://img.shields.io/cocoapods/l/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)
[![Platform](https://img.shields.io/cocoapods/p/JJCollectionViewRoundFlowLayout_Swift.svg?style=flat)](https://cocoapods.org/pods/JJCollectionViewRoundFlowLayout_Swift)


 JJCollectionViewRoundFlowLayout_Swift是JJCollectionViewRoundFlowLayout（OC：https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout ） 的Swift版本，JJCollectionViewRoundFlowLayout可设置CollectionView的BackgroundColor，可根据用户Cell个数计算背景图尺寸，可自定义是否包括计算CollectionViewHeaderView、CollectionViewFootererView或只计算Cells。设置简单，可自定义背景颜色偏移，设置显示方向（竖向、横向）显示,不同Section设置不同的背景颜色，可设置cell对齐方式。

   可设置内容：  
   1、collectionView section底色。  
   2、是否包含headerview。  
   3、是否包含footerview。  
   4、支持borderWidth、borderColor。  
   5、支持shadow投影。  
   6、支持collectionView，Vertical，Horizontal。  
   7、支持根据不同section分别设置不同底色显示。  
   8、支持根据section单独判断是否计算对应headerview和footerview  
   9、新增对Cell的对齐模式进行设置，支持（左对齐）--- V2.0.0  
   10、增加对不规则Cell大小的计算方式支持，支持对不规则Cell计算实际背景视图大小，默认不开启计算，如使用不规则计算需手动开启isCalculateTypeOpenIrregularitiesCell字段  
    11、新增对Cell的对齐模式进行设置，支持（居中对齐）--- V2.1.0  
    12、新增对Cell的对齐模式进行设置，支持（右对齐）--- V2.2.0  
    13、新增对Cell的对齐模式进行设置，支持（右对齐和首个Cell右侧开始）--- V2.3.0   
    14、内部优化 --- V2.3.1  
    15、增加对背景图的点击事件处理和控制，通过代理返回点击的背景图的IndexPath --- V2.4.0  
    16、增加支持Cell个数为0时，可以单独对Section的Header&Footer进行计算，支持全局设置和单独根据Section设置是否计算。---V2.5.0  
    17、解决设置了计算头和尾后, 但返回的第一个section的footer大小为0, 引起的crash。(感谢mengshun对问题的指出合修复)---V2.5.2  
    
    
    
   
   Swift版本地址：[GitHub地址](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift)
   
   OC版本地址：[GitHub地址](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout)
   
   
   ## 更新日志
   ---
   * `2.5.2`:解决设置了计算头和尾后, 但返回的第一个section的footer大小为0, 引起的crash。(感谢mengshun对问题的指出合修复)。  
   - `2.5.1`:修复当cell大小不一时，首个Cell单独在首行显示时,底色判断出错问题。  
   - `2.5.0`:增加支持Cell个数为0时，可以单独对Section的Header&Footer进行计算，支持全局设置和单独根据Section设置是否计算。  
   - `2.4.0`:增加对背景图的点击事件处理和控制，通过代理返回点击的背景图的IndexPath。
   - `2.3.1`:解决对暗黑模式的支持问题（感谢Whaiyan小伙伴发现了问题）。
   - `2.3.0`:新增对Cell的对齐模式进行设置，支持（右对齐和首个Cell右侧开始）。
   - `2.2.0`:新增支持设置Cell对齐模式（右对齐）。
   - `2.1.0`:新增支持设置Cell对齐模式（居中对齐）。
   - `2.0.1`: 增加对不规则Cell大小的计算方式支持，支持对不规则Cell计算实际背景视图大小，默认不开启计算，如使用不规则计算需手动开启isCalculateTypeOpenIrregularitiesCell字段
   - `2.0.0`：  
   1、优化代码，对代码逻辑进行抽离，增加工具类等。  
   2、新增支持设置Cell对齐模式（左对齐）。
   - `1.1.0`：增加支持根据section单独判断是否计算对应headerview和footerview
   - `1.0.0`：初始项目  
      1、collectionView section底色。  
      2、是否包含headerview。  
      3、是否包含footerview。  
      4、支持borderWidth、borderColor。  
      5、支持shadow投影。  
      6、支持collectionView，Vertical，Horizontal。  
      7、支持根据不同section分别设置不同底色显示。  
      8、优化代码逻辑，增加根据支持根据不同section分别设置不同底色逻辑和demo

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

#### 支持根据不同section分别单独设置是否计算对应Headerview和footerview

![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/6.png)

``` swift

/// 根据section设置是否包含headerview（实现该方法后，isCalculateHeader将不会生效）
/// - Parameters:
///   - collectionView: collectionView description
///   - layout: layout description
///   - section: section description
func collectionView(collectionView: UICollectionView,layout: UICollectionViewLayout, isCalculateHeaderViewIndex section: NSInteger) -> Bool {
    //这里简单设置了默认间隔一个就计算footerview，后续根据实际业务进行设置
    if (section % 2 == 0) {
        return true;
    }
    return false;
}

/// 根据section设置是否包含footerview（实现该方法后，isCalculateFooter将不会生效）
/// - Parameters:
///   - collectionView: collectionView description
///   - layout: layout description
///   - section: section description
func collectionView(collectionView: UICollectionView,layout: UICollectionViewLayout, isCalculateFooterViewIndex section: NSInteger) -> Bool {
    //这里简单设置了默认间隔一个就计算footerview，后续根据实际业务进行设置
    if (section % 2 == 0) {
        return true;
    }
    return false;
}

```

#### 支持对Cell的对齐模式进行设置、可选是否填充底色(左对齐)
  
  ![](https://github.com/kingjiajie/JJCollectionViewRoundFlowLayout_Swift/blob/master/7.png)
 
``` swift

    let layout = JJCollectionViewRoundFlowLayout_Swift.init();
    layout.isRoundEnabled = false; //设置是否填充底色
    layout.collectionCellAlignmentType = .Left; //设置对齐方式
    //layout.collectionCellAlignmentType = .Center; //设置对齐方式
    //layout.collectionCellAlignmentType = .Right; //设置对齐方式
    //layout.collectionCellAlignmentType = .RightAndStartR; //设置对齐方式(右对齐和首个Cell右侧开始）

```

#### 增加对背景图的点击事件处理和控制，通过代理返回点击的背景图的IndexPath

``` swift
    func collectionView(collectionView: UICollectionView, didSelectDecorationViewAtIndexPath indexPath: IndexPath) {
    let message = String.init(format: "section --- %ld \n row --- %ld", indexPath.section,indexPath.row)
}

```


## Author

kingjiajie, kingjiajie@sina.com

## License

JJCollectionViewRoundFlowLayout_Swift is available under the MIT license. See the LICENSE file for more info.
