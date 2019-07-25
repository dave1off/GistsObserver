import Foundation

protocol GOGistCommitsPresenterProtocol {
    
    func onViewDidLoad()
    
}

class GOGistCommitsPresenterImplementation: GOGistCommitsPresenterProtocol {
    
    private let getGistCommits: GOGetGistCommitsUseCaseProtocol
    
    private let gistID: String
    
    private weak var view: GOGistCommitsViewProtocol?
    
    init(
        getGistCommits: GOGetGistCommitsUseCaseProtocol,
        gistID: String,
        view: GOGistCommitsViewProtocol
    ) {
        self.getGistCommits = getGistCommits
        self.gistID = gistID
        self.view = view
    }
    
    func onViewDidLoad() {
        getGistCommits.getCommits(id: gistID) { commitsDomain, error in
            guard let commits = commitsDomain, error == nil else {
                self.view?.loadingFailure()
                return
            }
            
            let viewModels = commits.map {
                GOGistCommitViewModel(
                    authorName: $0.user.login,
                    additions: $0.changes.additions,
                    deletions: $0.changes.deletions
                )
            }
            
            GOExecutor.executeOnMain {
                self.view?.commitsLoaded(commits: viewModels)
            }
        }
    }
    
}
