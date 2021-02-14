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
var i: Int = 0
var searchMemo: String!
var searchEdit: String!
var Sbar: Int = 0

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchResultsUpdating {
   
    var searchController = UISearchController(searchResultsController: nil)
    var searchResult = [String]() //検索結果配列
  
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var searchController: UISearchController!
    
   // var selectedText: UITextView?
    var giveData: String = ""
    var Snum: Int = 0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            Snum = indexPath.row
        }
        else
        {
            //セル付属のtextLabelにTodoMemoの中身を入れる
            TodoCell.textLabel!.text = TodoMemo[indexPath.row]
            //print(TodoMemo[indexPath.row])
        }
        
        return TodoCell
    }
    
    //セルの消去
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                TodoMemo.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                
                //消去した内容を保存
                UserDefaults.standard.set(TodoMemo, forKey: "Todo")
            }
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
                        print(Enum)
                        print(TodoMemo[i])
                    }
                }
                next.detail = searchResult[num]
                print("search")
            }
            else
            {
                next.detail = TodoMemo[num]
                print("Memo")
            }
           // print(next.detail!)
           // print(searchResult.count)
        }
        
    }
    
    //検索ボタンを押した時の呼び出しメソッド
    func updateSearchResults(for searchController: UISearchController) {
        searchResult = TodoMemo.filter
        {
            data in return data.contains(searchController.searchBar.text!)
        }
        tableView.reloadData()
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // searchMemo.delegate = self
        //結果表示用のビューコントローラーに自分を設定する。
        searchController.searchResultsUpdater = self
        //検索中にコンテンツをグレー表示にしない
        searchController.dimsBackgroundDuringPresentation = false
        //テーブルビューのヘッダーにサーチバーを設定する。
        tableView.tableHeaderView = searchController.searchBar
        
       
        // Do any additional setup after loading the view.
        if UserDefaults.standard.object(forKey: "Todo") != nil{
            //Todoにデータがあったら, TodoMemoにデータを渡す
            TodoMemo = UserDefaults.standard.object(forKey: "Todo") as! [String]
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
