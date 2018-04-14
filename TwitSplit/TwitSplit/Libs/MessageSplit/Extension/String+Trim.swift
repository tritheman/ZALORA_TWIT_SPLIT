//
//  String.swift
//  String
//
//  Created by tri dang huu on 4/8/18.
//  Copyright © 2018 tri dang huu. All rights reserved.
//

import Foundation

extension String {

    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
