
import UIKit


extension UIViewController : UIGestureRecognizerDelegate{
    
    
    func hideKeyboardWhenTappedAround() {
        
        // tıkla
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // klavye gizle
    }
    
    //klavye bildirimini kaldır
    func removeKeyboardNotification() { //dinleme
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    
}

