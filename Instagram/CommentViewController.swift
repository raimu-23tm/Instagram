import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postId : String!
    var commentAuthor : String!
    
    @IBOutlet weak var commentTextView: PlaceHolderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // 更新データを書き込む
        let postRef =     Firestore.firestore().collection(Const.PostPath).document(postId)
    
        let commentText = commentAuthor + " : " + commentTextView.text!
        
        // FireStoreに投稿データを保存する(配列に値を追加)
        let postDic = [
            "comment": FieldValue.arrayUnion([commentText])
            ] as [String : Any]
        postRef.updateData(postDic)
                
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
