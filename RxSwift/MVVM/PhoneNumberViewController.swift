// PhoneNumberDisableViewController.swift
// 전화번호_입력_Disable

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneNumberViewController: UIViewController {
    
    let title_label_heigth = 24
    let textfield_width = 328
    let textfield_height = 48
    lazy var user_phone_number: String = ""
    
    lazy var label_title1: UILabel = {
        let label = UILabel()
        label.text = "전화번호를"
        label.textColor = .black
        return label
    }()
    
    lazy var label_title2: UILabel = {
        let label = UILabel()
        label.text = "전화번호를 입력해 주세요"
        label.textColor = .black
        return label
    }()

    lazy var textField_phoneNumber: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    lazy var button_next: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    var authViewModel: AuthViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        bind()
        button_next.addTarget(self, action: #selector(tapNextButton), for: .touchDown)
    }
    
    private func bind() {
        let input = AuthViewModel.PhoneNumberInput(text: textField_phoneNumber.rx.text.orEmpty.asObservable())
        
        guard let text = label_title1.text else { return }
        
        // bind가 subscribe의 개념이다.
        authViewModel = AuthViewModel(input: input, dependency: text)
        
        authViewModel.realPhoneNumberOutput.result
            .bind(to:label_title1.rx.text)
            .disposed(by: disposeBag)
        
        authViewModel.phoneNumberOutput.result
            .bind(to: label_title1.rx.text)
            .disposed(by: disposeBag)
            
    }
    
    private func setUI() {
        view.addSubview(label_title1)
        view.addSubview(label_title2)
        view.addSubview(textField_phoneNumber)
        view.addSubview(button_next)
        
        label_title1.snp.makeConstraints{ make in
            make.top.equalTo(view.snp.top).offset(100)
            make.height.equalTo(title_label_heigth)
            make.centerX.equalTo(view.snp.centerX)
            
        }
        
        label_title2.snp.makeConstraints{ make in
            make.top.equalTo(label_title1.snp.bottom).offset(10)
            make.height.equalTo(title_label_heigth)
            make.centerX.equalTo(view.snp.centerX)
            
        }
        
        textField_phoneNumber.snp.makeConstraints{ make in
            make.top.equalTo(label_title2.snp.bottom).offset(100)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(textfield_width)
            make.height.equalTo(textfield_height)
        }
        
        button_next.snp.makeConstraints{ make in
            make.top.equalTo(textField_phoneNumber.snp.bottom).offset(50)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }

    }

}


// MARK: - about tap button
extension PhoneNumberViewController {
    @objc func tapNextButton(_ sender: UIButton) {
        let passWordViewController = PassWordViewController()
        self.navigationController?.pushViewController(passWordViewController, animated: true)
    }
    
//    @objc func tapLoginButton(_ sender: UIButton) {
//        let phoneNumberDisalbeViewController = PhoneNumberViewController()
//        self.navigationController?.pushViewController(phoneNumberDisalbeViewController, animated: true)
//    }
}
