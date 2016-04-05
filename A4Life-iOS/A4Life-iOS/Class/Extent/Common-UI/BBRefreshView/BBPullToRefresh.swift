//
//  BBPullToRefresh.swift
//  BBSwiftFramework
//
//  Created by Bei Wang on 10/29/15.
//  Copyright © 2015 BooYah. All rights reserved.
//

import UIKit

class Animator: RefreshViewAnimator {
    private let refreshView: BBRefreshView
    
    init(refreshView: BBRefreshView) {
        self.refreshView = refreshView
    }
    
    func animateState(state: State) {
        // animate refreshView according to state
        switch state {
        case .Inital:        // do inital layout for elements
            break
        case .Releasing( _): // animate elements according to progress
            refreshView.refreshImageView?.startAnimatingGif()
            break
        case .Loading:       // start loading animations
            break
        case .Finished:      // show some finished state if needed
            refreshView.refreshImageView?.stopAnimatingGif()
            break
        }
    }
}


class BBPullToRefresh: PullToRefresh {

    convenience init() {
        let refreshView = BBRootView.getViewFromXib("BBRefreshView") as! BBRefreshView
        let animator = Animator(refreshView: refreshView)
        self.init(refreshView: refreshView, animator: animator)
    }
}
