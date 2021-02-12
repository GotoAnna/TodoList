//
//  MemoViewController.swift
//  Memo
//
//  Created by Mac on 2021/02/11.
//

import UIKit

var TodoMemo = [String]()

class MemoViewController: UIViewController {

    @IBOutlet var contentTextView: UITextView!
  
    //ユーザーデフォルトにアクセスする方法
    //var saveData: UserDefaults = UserDefaults.standard //saveDataという名のインスタンスをつくり, 倉庫をつくる
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //contentTextView.text = saveData.object(forKey: "content")as? String
    }
    
    //cancelボタン
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController!.popViewController(animated: true)
    }
    
    //saveボタン
    @IBAction func saveMemo()
    {
        //UserDefaultsに書き込み
        //UserDefaultsに鍵を使って書き込む
        //saveData.set(contentTextView.text, forKey: "content")
        
        TodoMemo.append(contentTextView.text!) //変数に入力内容を入れる
       
        UserDefaults.standard.set(TodoMemo, forKey: "Todo") //変数の中身をUserDefaultsに追加
        
        //alertを出す
        let alert: UIAlertController = UIAlertController(title:"保存", message: "メモの保存が完了しました。", preferredStyle: .alert)
        
        //OKボタン
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: {action in
                    self.navigationController?.popViewController(animated: true) //ボタンが押された時の動作
                    print("OKボタンが押されました！")
                }
                )
        )
        present(alert, animated: true, completion: nil)
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
