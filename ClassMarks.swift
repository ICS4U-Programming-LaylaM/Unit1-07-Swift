//
//  ClassMarks.swift
//
//  Created by Layla Michel
//  Created on 2022-03-23
//  Version 1.0
//  Copyright (c) 2022 IMH. All rights reserved.
//
//  This program reads from two files, generates random marks
// and creates a 2d array containing the names and marks that
// gets sent to a new file.

import Foundation

func generateMarks(namesArray: [String], assignsArray: [String]) -> [[String]] {
    let rows: Int = namesArray.count
    let columns: Int = assignsArray.count + 1

    var twoDimensionArray = Array(repeating: Array(repeating: "", count: columns), count: rows)

    for name in 0..<rows {
        twoDimensionArray[name][0] = namesArray[name]
    }

    for counter in 1..<columns {
        for counter2 in 0..<rows {
            twoDimensionArray[counter2][counter].append(String(Int.random(in: 50...100)))
        }
    }

    return twoDimensionArray
}

do {
    // Read command line arguments for file name
    let arguments = CommandLine.arguments
    let names: String = arguments[1]
    let assigns: String = arguments[2]

    let set1 = try String(contentsOfFile: names, encoding: String.Encoding.utf8)
    let arrayStudents: [String] = set1.components(separatedBy: "\n")
    let set2 = try String(contentsOfFile: assigns, encoding: String.Encoding.utf8)
    let arrayAssigns: [String] = set2.components(separatedBy: "\n")

    let array2d: [[String]] = generateMarks(namesArray: arrayStudents, assignsArray: arrayAssigns)

    let text = ""

    try text.write(to: URL(fileURLWithPath: "/home/runner/Unit1-07-Swift/marks.csv"),
        atomically: false, encoding: .utf8)
    if let fileWriter = try? FileHandle(forUpdating: URL(fileURLWithPath: "/home/runner/Unit1-07-Swift/marks.csv")) {
        for array in array2d {
            let arrayString = array.joined(separator: " ") + "\n"
            fileWriter.seekToEndOfFile()
            fileWriter.write(arrayString.data(using: .utf8)!)
        }
        fileWriter.closeFile()
    }

    print("Marks added to 'marks.cvs'")
} catch {
    // Error message if nonexistent file is inputted
    Swift.print("File does not exist.")
}
