//
//  ContentView.swift
//  CSKorMed
//
//  Created by Sung Park on 7/1/23.
//

import SwiftUI
import RealityKit
import MaleBody

struct ContentView: View {
    static let markersQuery = EntityQuery(where: .has(PointComponent.self))
    static let runtimeQuery = EntityQuery(where: .has(PointRuntimeComponent.self))
    
    @State private var subscriptions = [EventSubscription]()
    @State private var attachmentsProvider = AttachmentsProvider()
    
    var viewModel: ViewModel

    var body: some View {
        RealityView { content, _ in
            if let entity = try? await Entity(named: "Scene", in: MaleBody.maleBodyBundle) {
                viewModel.rootEntity = entity
                content.add(entity)
                
                subscriptions.append(content.subscribe(to: ComponentEvents.DidAdd.self, componentType: PointComponent.self) { event in
                    createPoint(for: event.entity)
                })
            } else {
                print("Entity is null")
            }
        } update: { content, attachments in
            viewModel.rootEntity?.scene?.performQuery(Self.runtimeQuery).forEach { entity in
                guard let component = entity.components[PointRuntimeComponent.self] else { return }

                // Get the entity from the collection of attachments keyed by tag.
                guard let attachmentEntity = attachments.entity(for: component.attachmentTag) else { return }
                
                viewModel.rootEntity?.addChild(attachmentEntity)
                attachmentEntity.setPosition([0, 0.01, 0], relativeTo: entity)
                entity.components.set(OpacityComponent(opacity: 1.0))
            }
        } attachments: {
            ForEach(attachmentsProvider.sortedTagViewPairs, id: \.tag) { pair in
                pair.view
            }
        }
    }
    
    private func createPoint(for entity: Entity) {
        // If this entity already has a RuntimeComponent, don't add another one.
        guard entity.components[PointRuntimeComponent.self] == nil else { return }
        
        // Get this entity's PointComponent, which is in the Reality Composer Pro project.
        guard let point = entity.components[PointComponent.self] else { return }
        
        let tag: ObjectIdentifier = entity.id
        
        let view = LearnMoreView(
            name: point.name ?? "Unnamed",
            location: point.location ?? "",
            treatment: point.treatment ?? "",
            method: point.method ?? "",
            efficacy: point.efficacy ?? ""
        )
            .tag(tag)
        
        entity.components[PointRuntimeComponent.self] = PointRuntimeComponent(attachmentTag: tag)
        
        attachmentsProvider.attachments[tag] = AnyView(view)
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
