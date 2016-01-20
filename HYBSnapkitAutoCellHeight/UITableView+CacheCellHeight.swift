//
//  UITableView+CacheCellHeight.swift
//  demo
//
//  Created by huangyibiao on 16/1/19.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

private var __hyb_cache_cell_heigh_for_row_key = "__hyb_cache_cell_heigh_for_row"

///
/// 基于SnapKit扩展自动计算cell的高度
///
/// 作者：黄仪标
/// GITHUB：[HYBSnapkitAutoCellHeight](https://github.com/CoderJackyHuang/HYBSnapkitAutoCellHeight)
/// 作者博客：[标哥的技术博客](http://www.henishuo.com)
/// 作者微博：[标哥Jacky](http://weibo.com/u/5384637337)
extension UITableView {
  public var hyb_cacheHeightDictionary: [String: [String: CGFloat]]? {
    get {
      let dict = objc_getAssociatedObject(self,
        &__hyb_cache_cell_heigh_for_row_key) as? [String: [String: CGFloat]];
      
      if let cache = dict {
        return cache;
      }

      let cacheDict = [String: [String: CGFloat]]()
      objc_setAssociatedObject(self,
        &__hyb_cache_cell_heigh_for_row_key,
        cacheDict,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      return cacheDict;
    }
    
    set {
      objc_setAssociatedObject(self,
        &__hyb_cache_cell_heigh_for_row_key,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
}