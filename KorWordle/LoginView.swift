//
//  LoginView.swift
//  KorWordle
//
//  Created by Moon Jongseek on 2022/06/17.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Text("초성게임")
                .font(.largeTitle)
                .fontWeight(.heavy)
            AppleLoginButton()
                .frame(maxWidth: .infinity,
                       maxHeight: 44)
            Button {
                
            } label: {
                
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

