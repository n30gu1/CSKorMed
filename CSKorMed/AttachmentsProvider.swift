//
//  AttachmentsProvider.swift
//  CSKorMed
//
//  Created by Sung Park on 7/21/23.
//

import SwiftUI
import Observation

@Observable
final class AttachmentsProvider {

    var attachments: [ObjectIdentifier: AnyView] = [:]

    var sortedTagViewPairs: [(tag: ObjectIdentifier, view: AnyView)] {
        attachments.map { key, value in
            (tag: key, view: value)
        }.sorted { $0.tag < $1.tag }
    }
}
