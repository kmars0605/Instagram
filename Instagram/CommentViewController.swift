//
//  CommentViewController.swift
//  Instagram
//
//  Created by 伊藤光次郎 on 2020/09/26.
//  Copyright © 2020 kojiro.ito. All rights reserved.
//

import UIKit
import Firebase

class CommentViewController: UIViewController {
    
    var postData: PostData!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var captionLabel: UILabel!
    @IBAction func handlePostButton(_ sender: UIButton) {
        /*let name = Auth.auth().currentUser?.displayName
         let postRef = Firestore.firestore().collection(Const.PostPath).document()
         let postDic = [
         "name":name!,
         "comment":self.commentTextField.text!,
         ] as [String:Any]
         
         postRef.setData(postDic)
         postData.comment = commentTextField.text*/
        if commentTextField.text != nil{
            //更新データを作成する
            var updateCommentValue: FieldValue
            
            updateCommentValue = FieldValue.arrayUnion([commentTextField.text])
            print("aaaaa")
            print(commentTextField.text)
            
            print(updateCommentValue)
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comment": updateCommentValue])
            //現状、postDicにはコメントデータが入っているが、postDataには入っていない。
            print(postData.comment)
            
            self.dismiss(animated: true, completion: nil)
            //let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            //self.present(homeViewController!, animated: true, completion: nil)
        }
        
        //let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
        //postRef.updateData(["comment": commentTextField.text])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionLabel.text = ("\(postData.name!):\(postData.caption!)")
        
    }
    
    
    
    
    /*func setPostData(_ postData: PostData){
     self.captionLabel.text = "\(postData.name!):\(postData.caption!)"
     }*/
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
