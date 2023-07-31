//
//  ViewModel.swift
//  CSKorMed
//
//  Created by Sung Park on 7/22/23.
//

import Foundation
import RealityKit
import Observation
import MaleBody

@Observable
final class ViewModel {
    var rootEntity: Entity? = nil
    
    init(rootEntity: Entity? = nil) {
        self.rootEntity = rootEntity
    }
}
