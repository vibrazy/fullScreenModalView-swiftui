//
//  FullScreenScrollView.swift
//  BrainFlowSDK
//
//  Created by Dan Tavares on 28/01/2020.
//  Copyright © 2020 Dan Tavares. All rights reserved.
//

#if canImport(SwiftUI)

import SwiftUI

private struct FullScreenScrollViewModifier: ViewModifier {
	let axis: Axis.Set
	let backgroundColor: Color

	func body(content: Content) -> some View {
		GeometryReader { geometry in
			ZStack {
				self.backgroundColor.edgesIgnoringSafeArea(.all)
				ScrollView(self.axis) {
					if self.axis == .horizontal {
						content.frame(height: geometry.size.height)
					} else {
						content.frame(width: geometry.size.width)
					}
				}
			}
		}
	}
}

private struct StackViewAxisModifier: ViewModifier {
	let axis: Axis.Set
	func body(content: Content) -> some View {
		if axis == .horizontal {
			return HStack {
					content
				}.eraseToAnyView()
		} else {
			return VStack {
				content
			}.eraseToAnyView()
		}
	}
}

extension View {
    public func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

public struct FullScreenModal<Content>: View where Content: View {
    let content: () -> Content
	public let backgroundColor: Color
	public var axis: Axis.Set = .vertical

	public init(axis: Axis.Set, backgroundColor: Color, @ViewBuilder content: @escaping () -> Content) {
		self.axis = axis
		self.backgroundColor = backgroundColor
        self.content = content
    }

   public var body: some View {
		content()
			.modifier(StackViewAxisModifier(axis: axis))
			.modifier(FullScreenScrollViewModifier(axis: axis, backgroundColor: backgroundColor))
    }
}

#endif
