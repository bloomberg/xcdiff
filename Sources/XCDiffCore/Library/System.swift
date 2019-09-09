//
// Copyright 2019 Bloomberg Finance L.P.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

protocol System {
    func execute(arguments: [String]) throws -> String
}

final class DefaultSystem: System {
    func execute(arguments: [String]) throws -> String {
        let task = Process()
        let outPipe = Pipe()
        task.launchPath = "/usr/bin/env"
        task.arguments = arguments
        task.standardOutput = outPipe
        task.launch()
        task.waitUntilExit()
        guard task.terminationStatus == 0 else {
            throw ComparatorError.generic("The command returned with \(task.terminationStatus) code")
        }
        let outdata = outPipe.fileHandleForReading.readDataToEndOfFile()
        guard let string = String(data: outdata, encoding: .utf8) else {
            throw ComparatorError.generic("Cannot decode the command output")
        }
        return string
    }
}
