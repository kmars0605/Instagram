//
//  TabBarController.swift
//  Instagram
//
//  Created by 伊藤光次郎 on 2020/09/16.
//  Copyright © 2020 kojiro.ito. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        //タブバーの背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
       //UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する
        self.delegate = self
    }
    
    //タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理する。
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController{
            //ImageSelectViewControllerは、タブ切り替えではなくモーダル画面遷移する。
            //真ん中のカメラボタンが押された時、instantiateViewControllerメソッドを使ってImageSelectViewControllerを読み込み。
            let imageSelectViewController = storyboard!.instantiateViewController(identifier: "ImageSelect")
            present(imageSelectViewController,animated: true)
            //falseで返すとタブ切り替えが行われない。
            return false
        }else{
            //その他のViewControllerは通常のタブ切り替えを実施。trueで返すとタブ切り替えが行われる。
            return true
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
