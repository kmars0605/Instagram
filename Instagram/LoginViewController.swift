//
//  LoginViewController.swift
//  Instagram
//
//  Created by 伊藤光次郎 on 2020/09/15.
//  Copyright © 2020 kojiro.ito. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    
    //ログインボタンをタップした時に呼ばれるメソッド
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAdressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text{
            
            //アドレスとパスワードと表示名のいずれかでも入力されて無かったら何もしない
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                SVProgressHUD.showError(withStatus:"必要項目を入力してください")
                //print("DEBUG_PRITNT:中がから文字です")
                return
            }
            //HUDで処理中を表示
            SVProgressHUD.show()
            //アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログイン
            Auth.auth().createUser(withEmail: address, password: password){
                authReslut, error in
                //クロージャ内の処理
                if let error = error{
                    //エラーがあった原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                    return
                }
                print("DEBUG_PRITN:ログインに成功しました。")
                //HUDを消す
                SVProgressHUD.dismiss()
                
                //画面を閉じてタブ画面に戻る
                self.dismiss(animated: true, completion: nil)
                print("DEBUG_PRINT:ユーザー作成に成功しました。")
                
                
            }
        }
        
    }
    
    //アカウント作成ボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCreateAccountButton(_ sender: Any) {
        if let address = mailAdressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text{
            //アドレスとパスワードと表示名のいずれかでも入力されていない時は何もしない
            if address.isEmpty || password.isEmpty || displayName.isEmpty {
                print("DEBUG_PRITNT:何かが空文字です")
                SVProgressHUD.showError(withStatus:"必要項目を入力してください")
                
                return
            }
            //HUDで処理中を表示
            SVProgressHUD.show()
            
            
            
            //アドレスとパスワードでユーザー作成。ユーザー作成に成功すると、自動的にログイン
            Auth.auth().createUser(withEmail: address, password: password){
                authReslut, error in
                //クロージャ内の処理
                if let error = error{
                    //エラーがあった原因をprintして、returnすることで以降の処理を実行せずに処理を終了する
                    print("DEBUG_PRINT:" + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました")
                    return
                }
                print("DEBUG_PRITN:ユーザー作成に成功しました。")
                
                //表示名を設定する
                let user = Auth.auth().currentUser
                if let user = user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges{ error in
                        if let error = error{
                            //プロフィールの更新でエラーが発生
                            print("DEBUG_PRINT" + error.localizedDescription)
                            SVProgressHUD.showError(withStatus: "表示名の設定に失敗しました。")
                            return
                        }
                        
                        print("DEBUG_PRINT:[displayName = \(user.displayName!)]")
                        //HUDを消す
                        SVProgressHUD.dismiss()
                        
                        //画面を閉じてタブ画面に戻る
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
