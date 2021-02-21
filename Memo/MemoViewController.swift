//
//  MemoViewController.swift
//  Memo
//
//  Created by Mac on 2021/02/11.
//

import UIKit

var TodoMemo = [String]()
var dateText = [String]()
//var dateText = [Date]()
class MemoViewController: UIViewController, UITextFieldDelegate {
    
    var detail: String!
    var date: String!
    var DATE: String!
    var editDate: Date!
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var Picker: UIDatePicker!
  
    //ユーザーデフォルトにアクセスする方法
    //var saveData: UserDefaults = UserDefaults.standard //saveDataという名のインスタンスをつくり, 倉庫をつくる
    
    override func viewDidLoad() {
        super.viewDidLoad()
       contentTextView!.text = detail
        //Picker.date = editDate
       //dateLabel!.text = date
        DATE = date
        //print("中身：\(date!)")
        //contentTextView.text = saveData.object(forKey: "content")as? String
       // contentTextView.text = "本文"
        //print(contentTextView)
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))//ツールバーのインスタンス生成
        toolBar.barStyle = UIBarStyle.default //スタイルを設定
        toolBar.sizeToFit() //画面はばに合わせてサイズを変更
        
        //閉じるボタンをみぎに配置するためのスペース
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(MemoViewController.commitButtonTapped))
        //スペース、閉じるボタンを右側に配置
        toolBar.items = [spacer, commitButton]
        // テキストフィールドにツールバーを設定
        contentTextView.inputAccessoryView = toolBar
       /* let formatter = DateFormatter()
        formatter.dateFormat = "M/d(EEE) HH:mm"
        formatter.locale = Locale(identifier: "ja_JP")
        print(formatter.date(from: DATE))*/
       // Picker.date = DateFormatter().date(from: DATE)!
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
       
        //dateLabel!.text = "\(Picker.date)"
    }
    
    @objc func commitButtonTapped() {
            self.view.endEditing(true)
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
        //detail = contentTextView.text!
        //date = "\(Picker.date)"
       // dateLabel!.text = "\(Picker.date.string(from: Date())"
        //dateLabel!.text = "\(Picker.date)"
        Picker.datePickerMode = UIDatePicker.Mode.dateAndTime
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat =  DateFormatter.dateFormat(fromTemplate: "M/d(EEE)HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
            //"MMM dd, yyyy"
        let selectedDate = dateFormatter.string(from: Picker.date)
        
        //dateLabel!.text = selectedDate
        DATE = selectedDate
        if(flag == 1) //メモ一覧のセルをタップして編集する時
        {
            TodoMemo[num] = contentTextView.text!
            dateText[num] = DATE
            print("日付:\(String(describing: DATE))")
                //dateLabel.text!
            //dateLabel!.text = selectedDate
            print("Memo=\(TodoMemo[num])")
        }
        else if flag == 2 //検索結果のセルをタップして編集する時
        {
            TodoMemo[Enum] = contentTextView.text!
            dateText[Enum] = DATE
                //dateLabel.text!
            print("Memo=\(Enum)")
            print("Memo=\(TodoMemo[Enum])")
            //print("Date=\(dateLabel.text!)")
            print("Date = \(Enum)")
        }
        
        else //新規ボタンを押した時
        {
            //let selectedDate = dateFormatter.string(from: Picker.date)
            //let selectedDate = Picker.date
            //DATE = selectedDate
            TodoMemo.append(contentTextView.text!) //変数に入力内容を入れる
            dateText.append(DATE)
            print("新規\(String(describing: DATE))")
            print(dateText)
                //dateLabel.text!) //日付
        }
        
        UserDefaults.standard.set(TodoMemo, forKey: "Todo") //変数の中身をUserDefaultsに追加
        UserDefaults.standard.set(dateText, forKey: "Date")
    
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
     
    //日付選択
    /*   @IBAction func changeDate(sender: UIDatePicker) {
        print("日付")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            
        dateLabel!.text = formatter.string(from: sender.date)
        
    }*/
    
    //shareボタン
    @IBAction func share() {
        let shareText = contentTextView.text!
        //let shareImage =
        
        let activityItems: [Any] = [shareText]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [UIActivity.ActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewController.excludedActivityTypes = excludedActivityTypes
        present(activityViewController, animated: true, completion: nil)
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
