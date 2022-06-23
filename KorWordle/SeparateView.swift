//
//  SeparateView.swift
//  KorWordle
//
//  Created by Moon Jongseek on 2022/06/16.
//

import SwiftUI

struct SeparateView: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Separate Consonants and Vowels")
                .font(.largeTitle)
                .fontWeight(.bold)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .padding(.top, 20)
            Text("한글을 입력하면 자모가 분리됩니다.")
                .font(.title)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
            
            Divider()
            
            ScrollView(.vertical) {
                Text(viewModel.charStringText)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(alignment: .leading)
            
            Spacer()
            
            TextField("한글만 입력해주세요.", text: $viewModel.inputText)
                .onChange(of: viewModel.inputText) { newText in
                    viewModel.hangulTextCheck()
                }
                .padding(5) // Default: 16
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(lineWidth: 1)
                        .fill(.gray)
                }
                .padding(.bottom, 20)
        }
        .padding()
    }
}

struct SeparateView_Previews: PreviewProvider {
    static var previews: some View {
        SeparateView()
    }
}
