//
//  Coordinator.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//


import SpriteKit
import SwiftUI


struct GameSpriteView: UIViewRepresentable {
    
    @ObservedObject var viewModel: GameVM
    
    let size: CGSize

    func makeUIView(context: Context) -> SKView {
        let view = SKView(frame: CGRect(origin: .zero, size: size))
        let scene = GameScene(viewModel: viewModel, size: size)
        scene.scaleMode = .resizeFill
        view.backgroundColor = .clear
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        if context.coordinator.viewModel != viewModel {
            context.coordinator.viewModel = viewModel
            let scene = GameScene(viewModel: viewModel, size: size)
            scene.scaleMode = .resizeFill
            uiView.presentScene(scene)
        }
    }

    func makeCoordinator() -> GSCoordinator {
        GSCoordinator(viewModel: viewModel)
    }

final class GSCoordinator: NSObject {
    
        var viewModel: GameVM

        init(viewModel: GameVM) {
            self.viewModel = viewModel
        }
    }
}
