//
//  ViewController.swift
//  demo
//
//  Created by huangyibiao on 16/1/15.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

import UIKit

let cellIdentifier = "TestCellIdentifier"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var dataSource = [TestModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for var i = 0; i < 2000; ++i {
      let model = TestModel()
      model.modelId = i + 1;
      model.title = "基于SnapKit写的自动计算行高的扩展，欢迎大家使用"
      model.desc = "基于SnapKit写的自动计算行高的扩展，欢迎大家使用。不仅可以根据约束自动调整高度的高度，还可以解决重用问题。使用自动布局是可以自动适配了，但是如果没有很好地解决重用问题，那么每次因为没有更新约束，可能会因为重用而导致错乱。这个demo不只是测试这个扩展类，更给大家带来一种解决重用问题的方案"
      
      model.blog = "作者博客名称：标哥的技术博客，网址：http://www.henishuo.com，欢迎大家关注。这里有很多的专题，包括动画、自动布局、swift、runtime、socket、开源库、面试等文章，都是精品哦。大家可以关注微信公众号：iOSDevShares，加入有问必答QQ群：324400294，群快满了，若加不上，对不起，您来晚了！"
      dataSource.append(model)
      
      if i % 2 == 0 {
        model.isExpand1 = true
      } else {
        model.isExpand1 = false
      }
      
      if i % 3 == 0 {
        model.isExpand2 = true
      } else {
        model.isExpand2 = false
      }
    }
    
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    self.view.addSubview(tableView)
    tableView.snp_makeConstraints { [unowned self](make) -> Void in
      make.edges.equalTo(self.view)
    }
    tableView.reloadData()
    tableView.separatorStyle = .None
  }
  
  deinit {
    print("deinit")
  }
  
// MARK: UITableViewDelegate
func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
  let model = self.dataSource[indexPath.row]
  
  var stateKey = "";
  if model.isExpand1 && model.isExpand2 {
    stateKey = "expand1&expand2"
  } else if !model.isExpand1 && !model.isExpand2 {
    stateKey = "unexpand1&unexpand2"
  } else if model.isExpand1 {
    stateKey = "expand1&unexpand2"
  } else {
    stateKey = "unexpand1&expand2"
  }
  
  return TestCell.hyb_cellHeight(forIndexPath: indexPath, config: { (cell) -> Void in
    let itemCell = cell as? TestCell
          itemCell?.config(testModel: model)
    }, cache: { () -> (key: String, stateKey: String, cacheForTableView: UITableView) in
      return (String(model.modelId), stateKey, tableView)
  })
}
  
  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? TestCell
    
    if cell == nil {
      cell = TestCell(style: .Default, reuseIdentifier: cellIdentifier)
      cell?.selectionStyle = .None
    }
    
    let model = self.dataSource[indexPath.row]
    cell?.config(testModel: model)
    cell?.expandBlock = { (type: Int, isExpand: Bool) -> Void in
      switch type {
      case 1:
        model.isExpand1 = isExpand
      default:
        model.isExpand2 = isExpand
      }
      
      tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    return cell!
  }
}

