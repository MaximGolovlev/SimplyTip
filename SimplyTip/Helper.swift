//
//  Helper.swift
//  SimplyTip
//
//  Created by Maxim Golovlev on 23.08.2025.
//

import Combine

func combineLatest5<P1, P2, P3, P4, P5>(
    _ p1: P1, _ p2: P2, _ p3: P3, _ p4: P4, _ p5: P5
) -> AnyPublisher<(P1.Output, P2.Output, P3.Output, P4.Output, P5.Output), P1.Failure>

where P1: Publisher, P2: Publisher, P3: Publisher, P4: Publisher, P5: Publisher,
      P1.Failure == P2.Failure, P2.Failure == P3.Failure,
      P3.Failure == P4.Failure, P4.Failure == P5.Failure {
    
    return Publishers.CombineLatest3(
        p1,
        Publishers.CombineLatest3(p2, p3, p4),
        p5
    )
    .map { ($0, $1.0, $1.1, $1.2, $2) }
    .eraseToAnyPublisher()
}
