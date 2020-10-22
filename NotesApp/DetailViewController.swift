//
//  DetailViewController.swift
//  NotesApp
//
//  Created by Yuvraj Vijay Agarkar on 22/10/20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var bodyTextView: UITextView!
    var slect:Note?
    var indexPath:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        if slect != nil,indexPath != nil {
            titleField.text = slect?.title
            bodyTextView.text = slect?.body
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if slect != nil,indexPath != nil {
            guard let title = titleField.text , let body = bodyTextView.text else {
                return
            }
            records[indexPath!].title = title
            records[indexPath!].body = body
            loadManager.save()
        }
    }
}
