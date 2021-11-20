
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // 가고 싶은 뷰 컨트롤러를 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") else {return}
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        // 가고 싶은 뷰 컨트롤러를 인스턴스화
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") else {return}
        // 풀 스크린으로 띄우고 싶다면
        // viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    
}

