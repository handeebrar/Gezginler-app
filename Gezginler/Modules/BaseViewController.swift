

import UIKit


// bu extension metotları kullanıyor
class BaseViewController: UIViewController {

    
    fileprivate var internalScrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    func showMessage(_ message: String?, withTitle title: String?) {
      
        let errorController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func showError(_ errorMessage: String?) {
      
        let errorController = UIAlertController(title: "Hata", message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    
    //
    func setupKeyboardNotifications(with scrollView: UIScrollView?) {
        internalScrollView = scrollView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
 
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 15.0, right: 0.0)
        
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
        
       
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
    }
    

}
