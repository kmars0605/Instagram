//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 伊藤光次郎 on 2020/09/23.
//  Copyright © 2020 kojiro.ito. All rights reserved.
//

import UIKit
import FirebaseUI
import Firebase

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBAction func commentButton(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //PostDataの内容をセルに表示
    func setPostData(_ postData: PostData)  {
        //画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        //キャプションの表示
        self.captionLabel.text = "\(postData.name!)　:　\(postData.caption!)"
        
        //改行したものをテキストに入れる
        if postData.comment != []{
            var text = ""
            //let name = Auth.auth().currentUser?.displayName
            for i in 0...postData.comment.count - 1 {
                let value = postData.comment[i]
                text += "\(value)\n"
                
            }
            
            self.commentLabel.text = text
        }else{
            self.commentLabel.text = ""
        }
       
        //日時の表示
        self.dateLabel.text = ""
        if let date = postData.date{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
        
        //いいねの数の表示
        let likeNumber = postData.likes.count
        likeLabel.text  = "\(likeNumber)"
        
        
        //いいねボタンの表示
        if postData.isLiked{
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
    
}
