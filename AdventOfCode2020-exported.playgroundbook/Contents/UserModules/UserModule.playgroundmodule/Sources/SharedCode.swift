// Code inside modules can be shared between pages and other source files.
import UIKit

public func OpenTextFile(fileName: String, extenstion: String = "txt") -> [String] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: extenstion) else {
        fatalError("Can not get input file")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can read data")
    }
    let text = String(decoding: data, as: UTF8.self)
    return text.components(separatedBy: .newlines)
}


public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
