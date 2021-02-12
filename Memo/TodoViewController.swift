//
//  TodoViewController.swift
//  Memo
//
//  Created by Mac on 2021/02/11.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var num: Int = 0
   // var selectedText: UITextView?
    var giveData: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TodoMemo.count //表示するセル数
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //変数を作る
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //変数にTodoMemoの中身を入れる
        TodoCell.textLabel!.text = TodoMemo[indexPath.row]
        num = indexPath.row
        
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
            tableView.reloadData() //TableViewの更新
        }
    
  /*
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        //selectedText = UITextView(named: TodoMemo[indexPath.row] as? String)
       
        if selectedText != nil {
            // SubViewController へ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "MemoViewController",sender: nil)
        }
    }*/
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "edit") {
           
            let sub: MemoViewController = (segue.destination as? MemoViewController)!
    
            sub.contentTextView = TodoMemo[tableView.indexPathForSelectedRow()!.row]
            
        }
    }
   
    /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let memo = TodoMemo[indexPath.row]
          
            let vc = MemoViewController.instance(memo)
            navigationController?.pushTodoViewController(vc, animated: true)
            print("vc animated true")
        }
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
