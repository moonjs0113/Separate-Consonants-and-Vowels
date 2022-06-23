//
//  ViewModel.swift
//  KorWordle
//
//  Created by Moon Jongseek on 2022/06/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var charStringText: String = ""
    
    func hangulTextCheck() {
//        let patternStringWithRawString: String = #"^[가-힣ㄱ-ㅎ0-9`~₩!@#$%^&*()_-+=\|[]{}<>,.?/ '"¥£•]{0,100}$"#
        let pattern: String = "^[가-힣ㄱ-ㅎ0-9,;:“‘”’\'\"~!?@¥£•#\\\\|/\\$%^&*()_+=\\-₩\\[\\]\\{\\}\\<\\>\\. ]{0,1000}$"
        let regex = try? NSRegularExpression(pattern: pattern)
        if regex?.firstMatch(in: inputText,
                             options: [],
                             range: NSRange(location: 0,
                                            length: inputText.count)) == nil {
            if !inputText.isEmpty {
                inputText.removeLast()
            }
        }
        
        charStringText = getSeparatedChar(word: inputText.trimmingCharacters(in: .whitespaces)).reduce("") { result, text in
            return result + " \(text)"
        }
    }
    
    func getSeparatedChar(word: String) -> [String] {
        var result: [String] = []
        for char in word {
            guard let unicodeScalar = UnicodeScalar(String(char)) else {
                return []
            }
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
        return result
    }
}
