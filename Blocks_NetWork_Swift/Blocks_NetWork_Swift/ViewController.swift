//
//  ViewController.swift
//  Blocks_NetWork_Swift
//
//  Created by 陈胜华 on 16/12/1.
//  Copyright © 2016年 oneyd.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Push", style: .plain, target: self, action: #selector(ViewController.pushAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "循环引用", style: .plain, target: self, action: #selector(pushLoopVC))
    }
    
    final func pushAction() {
        let blockVC : BlockTestViewController = BlockTestViewController()
        self.navigationController?.pushViewController(blockVC, animated: true)
    }
    
    final func pushLoopVC() {
        let blockVC : BlockLoopViewController = BlockLoopViewController.init()
        self.navigationController?.pushViewController(blockVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

