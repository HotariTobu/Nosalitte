//
//  DnDHost.swift
//  iPhone
//
//  Created by HotariTobu on 2021/08/28.
//

import SwiftUI
import UIKit

class ReorderingDnDHost: UIView {
    var onSnapshot = { UIImage() }
    
    private let onDragBegun: () -> Void
    private let onDragEnded: () -> Void
    private let onDropEntered: () -> Void

    private var previewView = UIImageView()
    private let previewParameters = UIDragPreviewParameters()
    private lazy var previewTarget = UIDragPreviewTarget(container: self, center: self.center)

    init(onDragBegun: @escaping () -> Void, onDragEnded: @escaping () -> Void, onDropEntered: @escaping () -> Void) {
        self.onDragBegun = onDragBegun
        self.onDragEnded = onDragEnded
        self.onDropEntered = onDropEntered

        super.init(frame: .zero)

        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true

        let dragInteraction = UIDragInteraction(delegate: self)
        dragInteraction.isEnabled = true
        self.addInteraction(dragInteraction)

        let dropInteraction = UIDropInteraction(delegate: self)
        self.addInteraction(dropInteraction)

        previewParameters.backgroundColor = .clear
        previewParameters.shadowPath = UIBezierPath()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReorderingDnDHost: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        previewView = UIImageView(image: onSnapshot())
        previewView.layer.shadowColor = UIColor.lightGray.cgColor
        previewView.layer.shadowRadius = 5
        
        return [UIDragItem(itemProvider: NSItemProvider())]
    }

    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        previewView.layer.shadowOpacity = 1

        return UITargetedDragPreview(view: previewView, parameters: previewParameters, target: previewTarget)
    }

    func dragInteraction(_ interaction: UIDragInteraction, sessionAllowsMoveOperation session: UIDragSession) -> Bool {
        onDragBegun()
        return true
    }

    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        previewView.layer.shadowOpacity = 0

        return UITargetedDragPreview(view: previewView, parameters: previewParameters, target: previewTarget)
    }

    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        onDragEnded()
    }
}

extension ReorderingDnDHost: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        onDropEntered()
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .cancel)
    }
}
