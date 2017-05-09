//
//  TeamStatsViewController+UIViewControllerPreviewing.swift
//  Turnir
//
//  Created by Adam Gorkoz on 09/05/2017.
//  Copyright © 2017 Adam Gorkoz. All rights reserved.
//

import UIKit

extension LeagueViewController : UIViewControllerPreviewingDelegate {
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath) else {
                return nil }
        
        guard let TeamPageViewController =
            storyboard?.instantiateViewController(
                withIdentifier: "TeamPageViewController") as?
            TeamPageViewController else { return nil }
        
        TeamPageViewController.currentTeam = leagueTeams[indexPath.row]
        TeamPageViewController.preferredContentSize =
            CGSize(width: 0.0, height: 600)
        
        previewingContext.sourceRect = cell.frame
        
        return TeamPageViewController
    }
}
