//
//  TodoViewController.swift
//  Memo
//
//  Created by Mac on 2021/02/11.
//

import UIKit
var flag: Int = 0
var num: Int = 0
var Enum: Int = 0
var Tnum: Int = 0

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchResultsUpdating {
    
   
    var searchController = UISearchController(searchResultsController: nil)
    var searchResult = [String]() //検索結果配列
    var searchDate = [String]() //検索結果日付
    var i: Int = 0
    var j: Int = 0
    var searchMemo: String!
    var searchEdit: String!
    var Sbar: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var EditButton: UIBarButtonItem!
    
    //@IBOutlet weak var searchController: UISearchController!
    
    var giveData: String = ""
    var Snum: Int = 0
    var datecount: Int = 0
    var editflag: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> (Int) {
        if(searchController.searchBar.text! != "")
        {
            //print(searchResult.count)
            return searchResult.count
        }
        else{
            return TodoMemo.count //表示するセル数
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //ID付きのセルを取得する
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searchController.searchBar.text != "")
        {
            TodoCell.textLabel!.text = searchResult[indexPath.row]
           // print(searchDate[0])
            TodoCell.detailTextLabel!.text = searchDate[indexPath.row]
            Snum = indexPath.row
        }
        else
        {
            //セル付属のtextLabelにTodoMemoの中身を入れる
            
            TodoCell.textLabel!.text = TodoMemo[indexPath.row]
            print(indexPath.row)
            print(TodoMemo[indexPath.row])
            TodoCell.detailTextLabel!.text = dateText[indexPath.row]
            //print("保存\(dateText[indexPath.row])")
            //print("保存\(indexPath.row)")
            //print(TodoMemo[indexPath.row])
        }
        TodoCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return TodoCell
    }
    
    //編集モードの時のみ消去できるようにする
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .delete
        }
        return .none
    }
    //セルの消去
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                print("編集可")
                TodoMemo.remove(at: indexPath.row)
                dateText.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                
                //消去した内容を保存
                UserDefaults.standard.set(TodoMemo, forKey: "Todo")
                UserDefaults.standard.set(dateText, forKey: "Date")
            }
    }
    
    //セルの並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todoM = TodoMemo[sourceIndexPath.row]
        TodoMemo.remove(at: sourceIndexPath.row)
        TodoMemo.insert(todoM, at: destinationIndexPath.row)
        
        let todoD = dateText[sourceIndexPath.row]
        dateText.remove(at: sourceIndexPath.row)
        dateText.insert(todoD, at: destinationIndexPath.row)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            flag = 0
            i = 0
            tableView.reloadData() //TableViewの更新
        }
    
   
    //セルをタップしたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          
            flag = 1
            num = indexPath.row
            //画面遷移の前に検索バーを非表示にする
            //self.searchController.isActive = false
            performSegue(withIdentifier: "edit", sender: nil)
            self.searchController.isActive = false
        }
   
    //セルの中身を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "edit") {
           
            let next: MemoViewController = (segue.destination as? MemoViewController)!
           
           if (searchController.searchBar.text != "")
           {
                searchEdit = searchResult[num]
                for i in 0..<TodoMemo.count
                {
                    if searchEdit == TodoMemo[i] //検索結果の中身とリストのセルが同じだったら
                    {
                        flag = 2
                        Enum = i //リストの配列数保持
                        //print(Enum)
                        print(TodoMemo[i])
                    }
                }
                next.detail = searchResult[num]
                next.date = searchDate[num]
              //  print(searchDate[num])
            // print("search")
            }
            else
            {
                next.detail = TodoMemo[num]
                print("ひづけ:\(dateText[num])")
                //next.editDate.datePickerMode = UIDatePicker.Mode.dateAndTime
                /*DateFormatter().dateStyle = .short
                DateFormatter().timeStyle = .short
                DateFormatter().dateFormat =  DateFormatter.dateFormat(fromTemplate: "M/d(EEE)HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))*/
                //next.editDate = DateFormatter().date(from: dateText[num])!
                let d = DateFormatter().date(from: "2/23(Tue) 18:27")
                print("日付:\(d)")
                next.date = dateText[num]
                print(num)
                print("Memo")
            }
           // print(next.detail!)
           // print(searchResult.count)
        }
        
    }
    
    //検索文字列変更時の呼び出しメソッド
    func updateSearchResults(for searchController: UISearchController) {
        //検索文字列を含むデータを検索結果配列に格納する
        searchResult = TodoMemo.filter
        {
            //検索に入力した文字を含むデータを返す
            data in return data.contains(searchController.searchBar.text!)
        }
        //検索結果と同じ日付のindexPathをTodo一覧のセルから取得する
        searchDate = dateText
        for i in 0..<searchResult.count
        {
            for j in 0..<TodoMemo.count
            {
                if searchResult[i] == TodoMemo[j] //検索結果の中身とTodo一覧のセルが同じだったら
                {
                    Tnum = j //何番めの配列なのかを取得
                    print(Tnum)
                    //検索結果の日付の配列にTodo一覧から取得した日付を代入
                    searchDate[i] = dateText[Tnum] //Todo一覧のTnum番目のセル内容を代入
                    print("\(i): \(dateText[Tnum])")
                }
            }
            print(searchResult[i])
        }
       
        tableView.reloadData()
    }
    
    //編集
    @IBAction func changeMode(_ sender: Any) {
        if(tableView.isEditing == true)
        {
            tableView.isEditing = false //編集不可
            EditButton.title = "Edit"
            editflag = 0
        }
        else{
            tableView.isEditing = true //編集可
            EditButton.title = "Done"
            editflag = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // searchMemo.delegate = self
        //結果表示用のビューコントローラーに自分を設定する。
        searchController.searchResultsUpdater = self
        //検索中にコンテンツをグレー表示にしない
        searchController.dimsBackgroundDuringPresentation = false
        //ナビゲーションバーにセット
        navigationItem.searchController = searchController
        //サーチバーを常に表示
        navigationItem.hidesSearchBarWhenScrolling = false
        
       
        // Do any additional setup after loading the view.
       if UserDefaults.standard.object(forKey: "Todo") != nil{
            //Todoにデータがあったら, TodoMemoにデータを渡す
            TodoMemo = UserDefaults.standard.object(forKey: "Todo") as! [String]
        }
        
        if UserDefaults.standard.object(forKey: "Date") != nil{
            //Todoにデータがあったら, dateTextにデータを渡す
            dateText = UserDefaults.standard.object(forKey: "Date") as! [String]
        }
        
        //tableView?.reloadData()
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
