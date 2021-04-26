//
//  AuthService.swift
//  Pokushats
//
//  Created by Сергей Зайцев on 21.03.2021.
//

import Firebase
import FirebaseAuth

final class AuthService: NSObject, FirebaseAuthServiceProtocol {
    
    private let db = Firestore.firestore()
    
    private var currentPhoneNumber: String?
    
    func performSignIn(phoneNumber: String?, completion: @escaping (Result<Void, Errors>) -> Void) {
        
        guard let phoneNumber = phoneNumber else {
            completion(.success(()))
           // completion(.failure(.numberIsNotExist))
            return
        }
        
        Auth.auth().languageCode = Locale.current.languageCode
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
            if let error = error {
                completion(.success(()))
               // completion(.failure(.authWithPhoneNumberFailed(error: error)))
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            self?.currentPhoneNumber = phoneNumber
            completion(.success(()))
        }
    }
    
    func verifySmsCode(verificationCode: String?, completion: @escaping (Result<Void, Errors>) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            completion(.failure(.verificationIdNotFound))
            return
        }
        guard let verificationCode = verificationCode else {
            completion(.failure(.verificationCodeNotExist))
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            if let error = error {
                completion(.success(()))
               // completion(.failure(.authWithPhoneNumberFailed(error: error)))
            } else {
                self?.upload(phoneNumber: self?.currentPhoneNumber) { _ in }
                completion(.success(()))
            }
        }
    }
    
    private func upload(phoneNumber: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("Users").document(userId).setData(["phoneNumber": phoneNumber ?? "error"]) { error in
            if let error = error {
                completion(.success(()))
                //completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func isUserExist() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOutUser() throws {
        try Auth.auth().signOut()
    }
    
    func isUsernameExist(completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        db.collection("Users").document(userId).getDocument { document, error in
            
            guard error == nil else {
                completion(false)
                return
            }
            
            guard let username = document?.data()?["username"] as? String else {
                completion(false)
                return
            }
            
            completion(!username.isEmpty)
        }
    }
}
