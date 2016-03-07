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
private var __hyb_cache_cell_calheigh_for_row_key = "__hyb_cache_cell_calheigh_for_row_key"

///
/// 基于SnapKit扩展自动计算cell的高度
///
/// 作者：黄仪标
/// GITHUB：[HYBSnapkitAutoCellHeight](https://github.com/CoderJackyHuang/HYBSnapkitAutoCellHeight)
/// 作者博客：[标哥的技术博客](http://www.henishuo.com)
/// 作者微博：[标哥Jacky](http://weibo.com/u/5384637337)
extension UITableView {
  public var hyb_cacheHeightDictionary: NSMutableDictionary? {
    get {
      let dict = objc_getAssociatedObject(self,
        &__hyb_cache_cell_heigh_for_row_key) as? NSMutableDictionary;
      
      if let cache = dict {
        return cache;
      }
      
      let newDict = NSMutableDictionary()
      
      objc_setAssociatedObject(self,
        &__hyb_cache_cell_heigh_for_row_key,
        newDict,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      return newDict
    }
  }
  
  public var hyb_cacheCellDictionary: NSMutableDictionary? {
    get {
      let dict = objc_getAssociatedObject(self,
        &__hyb_cache_cell_calheigh_for_row_key) as? NSMutableDictionary;
      
      if let cache = dict {
        return cache;
      }
      
      let newDict = NSMutableDictionary()
      
      objc_setAssociatedObject(self,
        &__hyb_cache_cell_calheigh_for_row_key,
        newDict,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
      return newDict
    }
  }
}