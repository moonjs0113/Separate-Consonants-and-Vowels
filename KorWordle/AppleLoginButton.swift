//
//  AppleLoginButton.swift
//  KorWordle
//
//  Created by Moon Jongseek on 2022/06/17.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginButton: UIViewRepresentable {
    typealias UIViewType = AppleLoginView
    
    func makeUIView(context: Context) -> UIViewType {
        AppleLoginView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

class AppleLoginView: UIView, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func appleSignIn(_ sender: ASAuthorizationAppleIDButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let authorizationAppleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        authorizationAppleIDButton.addTarget(self, action: #selector(appleSignIn(_:)), for: .touchUpInside)
        authorizationAppleIDButton.translatesAutoresizingMaskIntoConstraints = false
//        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(authorizationAppleIDButton)
        NSLayoutConstraint.activate([
            authorizationAppleIDButton.widthAnchor.constraint(equalTo: self.widthAnchor),
            authorizationAppleIDButton.heightAnchor.constraint(equalTo: self.heightAnchor),
            authorizationAppleIDButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            authorizationAppleIDButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    
    //func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //    let appleIDProvider = ASAuthorizationAppleIDProvider()
    //    appleIDProvider.getCredentialState(forUserID: /* 로그인에 사용한 User Identifier */) { (credentialState, error) in
    //        switch credentialState {
    //        case .authorized:
    //            // The Apple ID credential is valid.
    //            print("해당 ID는 연동되어있습니다.")
    //        case .revoked
    //            // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
    //            print("해당 ID는 연동되어있지않습니다.")
    //        case .notFound:
    //            // The Apple ID credential is either was not found, so show the sign-in UI.
    //            print("해당 ID를 찾을 수 없습니다.")
    //        default:
    //            break
    //        }
    //    }
    //    return true
    //}
    //authorized : 해당 User Identifier 값이 앱과 연결이 허가되어있다.
    //revoked : 해당 User Identifier 값이 앱과 연결이 취소되어있다.
    //notFound : 해당 User Identifier 값이 앱과 연결을 찾을 수 없다.

}
