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

        // Do any additional setup after loading the view.
    }


    
}

private let MAX_TEXT_NUM = 40

extension GYTextViewVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > MAX_TEXT_NUM {
            textView.text = (textView.text as NSString).substring(to: MAX_TEXT_NUM)
            
        }
        
    }
}
