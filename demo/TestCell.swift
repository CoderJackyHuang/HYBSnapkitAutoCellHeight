//
//  TestCell.swift
//  demo
//
//  Created by huangyibiao on 16/1/16.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class TestCell: UITableViewCell {
  private var headImageView = UIImageView()
  private var titleLabel = UILabel()
  private var descLabel = UILabel()
  private var blogSummaryLabel = UILabel()
  private var okButton = UIButton()
  private var isExpand1 = true
  private var isExpand2 = true
  
  var expandBlock: ((type: Int, isExpand: Bool) ->Void)?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(headImageView)
    headImageView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(15)
      make.width.height.equalTo(80)
    }
    headImageView.image = UIImage(named: "head")
    
    // title
    self.contentView.addSubview(titleLabel)
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont.systemFontOfSize(26)
    titleLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(headImageView.snp_right).offset(15)
      make.right.equalTo(-15)
      make.top.equalTo(headImageView)
    }
    
    // 若不指定preferredMaxLayoutWidth属性，则计算会不准备，使用Masonry时，指定此属性
    // 是特别适配iOS6的，不过使用SnapKit则必须指定，否则自动计算的高度会不准确
    let width = UIScreen.mainScreen().bounds.size.width
    titleLabel.preferredMaxLayoutWidth = width - 30 - 15 - 80;
    
    self.contentView.addSubview(descLabel)
    descLabel.numberOfLines = 0
    descLabel.font = UIFont.systemFontOfSize(22)
    descLabel.snp_makeConstraints { (make) -> Void in
      make.left.right.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp_bottom).offset(15)
    }
    descLabel.preferredMaxLayoutWidth = titleLabel.preferredMaxLayoutWidth
    
    descLabel.userInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: Selector("onTapDesc"))
    descLabel.addGestureRecognizer(tap)
    
    self.contentView.addSubview(blogSummaryLabel)
    blogSummaryLabel.numberOfLines = 0
    blogSummaryLabel.font = UIFont.systemFontOfSize(22)
    blogSummaryLabel.snp_makeConstraints { (make) -> Void in
      make.left.right.equalTo(descLabel)
      make.top.equalTo(descLabel.snp_bottom).offset(15)
    }
    blogSummaryLabel.preferredMaxLayoutWidth = titleLabel.preferredMaxLayoutWidth
    
    let tap1 = UITapGestureRecognizer(target: self, action: Selector("onTapBlog"))
    blogSummaryLabel.userInteractionEnabled = true
    blogSummaryLabel.addGestureRecognizer(tap1)
    
    self.contentView.addSubview(okButton)
    okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    okButton.setTitle("计算高度的参考", forState: .Normal)
    okButton.backgroundColor = UIColor.greenColor()
    okButton.snp_makeConstraints { (make) -> Void in
      make.right.equalTo(-15)
      make.height.equalTo(45)
      make.top.equalTo(blogSummaryLabel.snp_bottom).offset(15)
    }
    
    blogSummaryLabel.backgroundColor = UIColor.redColor()
    descLabel.backgroundColor = UIColor.greenColor()
    
    let lineLabel = UILabel()
    lineLabel.backgroundColor = UIColor.lightGrayColor()
    self.contentView.addSubview(lineLabel)
    lineLabel.snp_makeConstraints { [unowned self] (make) -> Void in
      make.height.equalTo(1)
      make.left.equalTo(15);
      make.right.equalTo(0)
      make.bottom.equalTo(self.contentView)
    }
    
    
    self.hyb_lastViewInCell = okButton
    self.hyb_bottomOffsetToCell = 15
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
// MARK: Public
func config(testModel model: TestModel) {

  
  titleLabel.text = model.title
  descLabel.text = model.desc
  blogSummaryLabel.text = model.blog
  
  if model.isExpand1 != self.isExpand1 {
    self.isExpand1 = model.isExpand1
    
    if self.isExpand1 {
      descLabel.snp_remakeConstraints(closure: { (make) -> Void in
        make.left.right.equalTo(titleLabel)
        make.top.equalTo(titleLabel.snp_bottom).offset(15)
      })
    } else {
      descLabel.snp_updateConstraints(closure: { (make) -> Void in
        make.height.lessThanOrEqualTo(55)
      })
    }
  }
  
  if model.isExpand2 != self.isExpand2 {
    self.isExpand2 = model.isExpand2
    
    if self.isExpand2 {
      blogSummaryLabel.snp_remakeConstraints(closure: { (make) -> Void in
        make.left.right.equalTo(descLabel)
        make.top.equalTo(descLabel.snp_bottom).offset(15)
      })
    } else {
      blogSummaryLabel.snp_updateConstraints(closure: { (make) -> Void in
        make.height.lessThanOrEqualTo(55)
      })
    }
  }
}
  
  // MARK - Private Events
  func onTapDesc() {
    if let block = self.expandBlock {
      block(type: 1, isExpand: !self.isExpand1)
    }
  }
  
  func onTapBlog() {
    if let block = self.expandBlock {
      block(type: 2, isExpand: !self.isExpand2)
    }
  }
}