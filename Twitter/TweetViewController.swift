//
//  TweetViewController.swift
//  Twitter
//
//  Created by Vivian Ross on 4/30/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var characterCount: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 280
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        return newText.count <= characterLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterCount.text = String(format: "Characters remaining: %d", 280-textView.text.count)
    }
    
    
    override func viewDidLoad() {
        characterCount.text = "Characters remaining: 280"
        tweetText.delegate = self
        super.viewDidLoad()
        tweetText.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postTweet(_ sender: Any) {
        if (!tweetText.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetText.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
