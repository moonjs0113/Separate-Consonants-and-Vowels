//
//  ContentView.swift
//  KorWordle
//
//  Created by Moon Jongseek on 2022/06/16.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var charStringList: [String] = []
    
    func hangulTextCheck(newValue: String) {
        let pattern: String = "^[가-힣ㄱ-ㅎ0-9,\\. ]{0,100}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if regex?.firstMatch(in: newValue,
                             options: [],
                             range: NSRange(location: 0,
                                            length: newValue.count)) == nil {
            if !text.isEmpty {
                text.removeLast()
            }
        }
        
        charStringList = getFirstCharInString(word: text.trimmingCharacters(in: .whitespaces))
    }
    
    func getFirstCharInString(word: String) -> [String] {
        var result: [String] = []
        for char in word {
            print(char)
            if ",. ".contains(String(char)) {
                result.append(String(char))
            } else {
                if let unicodeScalar = UnicodeScalar(String(char)) {
                    if unicodeScalar.value >= 0xac00 {
                        let first = ((unicodeScalar.value - 0xac00) / 28) / 21
                        let middle = ((unicodeScalar.value - 0xac00) / 28) % 21
                        let last = (unicodeScalar.value - 0xac00) % 28
                        
                        if let unicodeValue = UnicodeScalar(0x1100 + first) {
                            result.append(String(unicodeValue))
                        }
                        
                        if let unicodeValue = UnicodeScalar(0x1161 + middle) {
                            result.append(String(unicodeValue))
                        }
                        if last != 0 {
                            if let unicodeValue = UnicodeScalar(0x11a6 + 1 + last) {
                                result.append(String(unicodeValue))
                            }
                        }
                    } else {
                        result.append(String(char))
                    }
                }
            }
        }
        return result
    }
    
    var body: some View {
        VStack {
            Spacer()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(charStringList, id: \.self) { char in
                        Text(char)
                            .aspectRatio(1, contentMode: .fit)
                            .overlay {
                                Rectangle()
                                    .stroke(lineWidth: 1)
                                    .fill(.red)
                            }
                    }
                }
                .padding(.bottom, 10)
            }
            TextField("한글 아무거나", text: $text)
                .onChange(of: text) { newText in
                    print(newText)
                    hangulTextCheck(newValue: text)
                }
                .padding(5) // Default: 16
                .overlay {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(lineWidth: 1)
                        .fill(.gray)
                }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
