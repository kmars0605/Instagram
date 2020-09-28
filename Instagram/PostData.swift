//
//  PostData.swift
//  Instagram
//
//  Created by 伊藤光次郎 on 2020/09/23.
//  Copyright © 2020 kojiro.ito. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comment: [String] = []
    
    init(document: QueryDocumentSnapshot){
        self.id = document.documentID
        print(self.id)
        let postDic = document.data()
        
        //抽象　as?　具体のダウンキャスト。失敗したらnil
        self.name = postDic["name"] as? String
        print(self.name)
        self.caption = postDic["caption"] as? String
        
        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()
        
        if let comment = postDic["comment"] as? [String]{
            self.comment = comment
            
        }
        print(self.comment)
        //likesというキーを設定しているposdDic配列の要素がString型の配列の要素にダウンキャストできる時、likesにpostDicのlikesというキーに設定されている要素をlikesという配列に入れる。
        if let likes = postDic["likes"] as? [String]{
         
            self.likes = likes
            
        }
        
        if let myid = Auth.auth().currentUser?.uid{
            //likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil{
                //myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }

}
