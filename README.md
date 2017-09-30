# swift-todo

This is the first app in a series of apps I'll be making, experimenting with different architectures and iOS APIs.

At bottom it's a basic todo app that integrates with Firebase and GitHub authorisation.

This particular app utilises the following libraries/architectures:

- ReSwift app architecture, a unidirectional data flow architecture, inspired by the Javascript store management library "Redux". This can be found at https://github.com/ReSwift/ReSwift
- MVVM - The entire app makes use of ViewModels to present data and handle interaction. The ViewModels interact with the ReSwift store directly and report change back to the UIViewControllers/UIViews.
- Unit Testing - currently this project has 57% code coverage, a little low but this only leaves out lean VCs, and third party wrappers.
- Firebase - this was used for my serverside architecture.
- GitHub/OAuth - this makes use of the OAuth protocol. More on that below.
