//
//  LabirinthSceneCoordinator.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/21/23.
//

import SpriteKit
import SwiftUI

struct LabirinthSpriteView: UIViewRepresentable {
    
    @ObservedObject var viewModel: GameVM
    
    let size: CGSize

    func makeUIView(context: Context) -> SKView {
        let view = SKView(frame: CGRect(origin: .zero, size: size))
        let scene = LabirinthScene(viewModel: viewModel, size: size)
        scene.scaleMode = .resizeFill
        view.backgroundColor = UIColor.clear
        view.presentScene(scene)
        return view
    }

    func updateUIView(_ uiView: SKView, context: Context) {
        if context.coordinator.viewModel != viewModel {
            context.coordinator.viewModel = viewModel
            let scene = LabirinthScene(viewModel: viewModel, size: size)
            scene.scaleMode = .resizeFill
            uiView.presentScene(scene)
        }
    }

    func makeCoordinator() -> LabirinthCoordinator {
        LabirinthCoordinator(viewModel: viewModel)
    }

final class LabirinthCoordinator: NSObject {
    
        var viewModel: GameVM

        init(viewModel: GameVM) {
            self.viewModel = viewModel
        }
    }
}
