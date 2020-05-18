//
//  GYTextViewVC.swift
//  IOS-Extension
//
//  Created by 郭为勇 on 2020/5/17.
//  Copyright © 2020 yunyi. All rights reserved.
//

import UIKit

class GYTextViewVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(_ :)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    /**
     使用通知监听UITextView值改变时候， 不可以给TextView赋值，否则发生崩溃
     reason: '-[NSConcreteNotification text]: unrecognized selector sent to instance 0x28378a9a0'
     */
    @objc func textChanged(_ noti: Notification) -> Void {
        if textView.text.count > MAX_TEXT_NUM {
            textView.text = (textView.text as NSString).substring(to: MAX_TEXT_NUM)
        }
    }
}

private let MAX_TEXT_NUM = 10

extension GYTextViewVC: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        if textView.text.count > MAX_TEXT_NUM {
//            textView.text = (textView.text as NSString).substring(to: MAX_TEXT_NUM)
//            //如果发生崩溃，就加这句代码
//            //textView.undoManager?.removeAllActions()
//        }
//
//    }
}
