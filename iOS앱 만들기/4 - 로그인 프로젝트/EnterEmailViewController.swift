import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigation bar 보이기
        navigationController?.navigationBar.isHidden = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // 화면을 켰을때 첫번째 커서가 이메일 텍스트필드에 오도록 편하게 설정
        emailTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        // 올바른 이메일과 비밀번호를 입력하기 전에는 버튼 비활성화
        nextButton.isEnabled = false
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Firebase 이메일 / 비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else {return}
            
            if let error = error {
                let code = (error as NSError).code
                switch code{
                case 17007: // 이미 가입한 계정일 때
                    // 로그인 하기
                    self.loginUser(withEamil: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
            
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEamil email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _, error in
            guard let self = self else {return}
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

// UITextFieldDelegate 설정
extension EnterEmailViewController: UITextFieldDelegate {
    // TextField 에 키보드 입력이 끝나면 키보드 버튼을 내리는 코드.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    // 이메일, 비밀번호 입력 하고 "다음" 버튼을 활성화 시키는 코드.
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
