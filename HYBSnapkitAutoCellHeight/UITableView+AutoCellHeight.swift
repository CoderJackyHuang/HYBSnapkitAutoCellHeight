//
//  UITableView+AutoCellHeight.swift
//  demo
//
//  Created by huangyibiao on 16/1/16.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

private var __hyb_lastViewInCellKey  = "__hyb_lastViewInCellKey"
private var __hyb_bottomOffsetToCell = "__hyb_bottomOffsetToCell"

///
/// 基于SnapKit扩展自动计算cell的高度
///
/// 作者：黄仪标
/// GITHUB：[HYBSnapkitAutoCellHeight](https://github.com/CoderJackyHuang/HYBSnapkitAutoCellHeight)
/// 作者博客：[标哥的技术博客](http://www.henishuo.com)
/// 作者微博：[标哥Jacky](http://weibo.com/u/5384637337)
private let __currentVersion = "1.0"

extension UITableViewCell {
  /// 所指定的距离cell底部较近的参考视图，必须指定，若不指定则会assert失败
  public var hyb_lastViewInCell: UIView? {
    get {
      let lastView = objc_getAssociatedObject(self, &__hyb_lastViewInCellKey);
      return lastView as? UIView
    }
    
    set {
      objc_setAssociatedObject(self,
        &__hyb_lastViewInCellKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
  }

  /// 可不指定，若不指定则使用默认值0
  public var hyb_bottomOffsetToCell: CGFloat? {
    get {
      let offset = objc_getAssociatedObject(self, &__hyb_bottomOffsetToCell);
      return offset as? CGFloat
    }
    
    set {
      objc_setAssociatedObject(self,
        &__hyb_bottomOffsetToCell,
        newValue,
        .OBJC_ASSOCIATION_ASSIGN);
    }
  }
  
  /**
   唯一的类方法，用于计算行高
   
   - parameter indexPath:	index path
   - parameter config:		在config中调用配置数据方法等
   
   - returns: 所计算得到的行高
   */
  public class func hyb_cellHeight(forIndexPath indexPath: NSIndexPath, config: ((cell: UITableViewCell) -> Void)?) -> CGFloat {
    let cell = self.init(style: .Default, reuseIdentifier: nil)
    
    if let block = config {
      block(cell: cell);
    }
    
    return cell.hyb_calculateCellHeight(forIndexPath: indexPath)
  }
  
  // MARK: Private
  private func hyb_calculateCellHeight(forIndexPath indexPath: NSIndexPath) -> CGFloat {
    assert(self.hyb_lastViewInCell != nil, "hyb_lastViewInCell property can't be nil")
    
    layoutIfNeeded()
    
    var height = self.hyb_lastViewInCell!.frame.origin.y + self.hyb_lastViewInCell!.frame.size.height;
    height += self.hyb_bottomOffsetToCell ?? 0.0
    
    return height
  }
}

