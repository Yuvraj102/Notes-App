//
//  AddViewController.swift
//  NotesApp
//
//  Created by Yuvraj Vijay Agarkar on 21/10/20.
//

import UIKit
protocol passData {
    func passData(title:String,body:String)
}
class AddViewController: UIViewController {
 
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var bodyTextView: UITextView!
    
    var delegate:passData!
    override func viewWillDisappear(_ animated: Bool) {
        guard let title = titleField.text , let body = bodyTextView.text else {
            
          return
        }
        loadManager.save()
        delegate.passData(title: title, body: body)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            bodyTextView.contentInset = .zero
        } else {
            bodyTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        bodyTextView.scrollIndicatorInsets = bodyTextView.contentInset

        let selectedRange = bodyTextView.selectedRange
        bodyTextView.scrollRangeToVisible(selectedRange)
    }
    @IBAction func backGroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    

}
extension AddViewController:UITextFieldDelegate {
    
}
