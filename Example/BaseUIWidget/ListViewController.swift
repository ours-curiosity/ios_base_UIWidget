//
//  ListViewController.swift
//  BaseUIWidget_Example
//
//  Created by walker on 2021/3/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import CTBaseFoundation
import CTBaseUIWidget
class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.listView)
        self.listView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(UIFit.navWithStatusBarHeight)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    
    lazy var listView: UITableView = {
        let listView = UITableView.init()
        listView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.className)
        listView.dataSource = self
        listView.delegate = self
        listView.mj_header = LFGRefreshHeader.init(refreshingBlock: {
            
        })
        return listView
    }()
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
        cell.detailTextLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}
