//
//  ExtString.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/11/22.
//

import Foundation

extension String {
    //    func words() -> [String] {
    //
    ////        let range = Range<String.Index>(self.startIndex, in: self.endIndex)
    //
    //        let range = Range()
    //
    //        var words = [String]()
    //
    //        self.enumerateSubstringsInRange(range, options: NSStringEnumerationOptions.ByWords) { (substring, _, _, _) -> () in
    //            words.append(substring)
    //        }
    //
    //        return words
    //    }
    //    extension String {
    subscript(idx: Int) -> Character { self[index(startIndex, offsetBy: idx)] }
//        subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
//    }
    //    }
}
