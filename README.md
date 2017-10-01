# swift-todo

This is the first app in a series of apps I'll be making, experimenting with different architectures and iOS APIs.

In terms of the app itself - it's a basic todo app that integrates with Firebase and GitHub authorisation.

For the rationale, I recently followed a ReactJS tutorial series on Udemy (check it out at https://www.udemy.com/the-complete-react-web-app-developer-course/learn/v4/overview). In that I had to make a simple ReactJS todo app that authorises with GitHub and draws it's data from Firebase.

Inspired by the React/Redux interplay, I looked around online for a similar iOS state management system, I found one, called ReSwift, and thought I'd try to replicate my work on the ReactJS project in Swift (my first programming language).

This particular app utilises the following libraries/architectures:

- ReSwift app architecture, a unidirectional data flow architecture, inspired by the Javascript store management library "Redux". This can be found at https://github.com/ReSwift/ReSwift
- MVVM - The entire app makes use of ViewModels to present data and handle interaction. The ViewModels interact with the ReSwift store directly and report change back to the UIViewControllers/UIViews.
- Unit Testing - currently this project has 57% code coverage, a little low but this only leaves out lean VCs, and third party wrappers.
- Firebase - this was used for my serverside architecture.
- GitHub/OAuth - this makes use of the OAuth protocol. More on that below.

## ReSwift

ReSwift is a store management system that enforces unidirectional dataflow. The app is broken down into the following parts:

- Actions (These are triggered from my view controllers, and are a predefined set of code designed to change state).
- Reducers (These catch the results of actions, and update the state accordingly).
- Store (This pulls the above two things together, dispatching actions and receiving new state from the reducers, this also holds the state)

<img src="https://github.com/ReSwift/ReSwift/raw/master/Docs/img/reswift_concept.png"/>

The various areas in the app that need state updates will "subscribe" to the store, by providing delegate functions that catch state changes.

Crucially, ReSwift utilizes structs to ensure an immutable state. The benefits here are that, as a developer, you enjoy a "Single Source of Truth", i.e. one source that *requires* proper processes to be adhered to in order to update.

## MVVM

MVVM is an alternative to MVC (colloquially called "Massive View Controllers") where you can reduce bloat in your View Controllers by delegating some of the presentation/interaction logic to things called *View Models*.

For a good example of this in action, take a look at my TodoViewController, vs. my TodosVM. The TodosViewController has a reference to TodosVM, and makes requests to it in the usual VC lifecycle. TodosVM, on the other hand, handles tap events (passed to it from the VC), make presentation decisions (e.g. filtering todos based on a search term) and in general help bind the data from my store to my view.

The challenge with MVVM is the interaction logic - while the VC should hold a reference to the ViewModel, it should never be the other way around (so ViewModels can be re-used elsewhere). This means that any changes to state that are received by the ViewModel should not be directly communicated back to the VC - an example of where this is important is in my AuthVM. The AuthVM is used on both the LaunchViewController (i.e. the splash screen) and the AuthViewController (the login screen), for slightly different things.

One option was to use ReSwift to bridge the gap between the AuthVM and these View Controllers. The idea is that the AuthVM will dispatch authorisation actions to the store, the actions will authorise the user, and update the store with a user authentication state (either logged in, not logged in or error). Then the VC would subscribe to the store and catch these updates, making the necessary actions (e.g. if the user is logged in, segue to the home page).

I actually think this would have been fine, but it does leave the View Controllers tightly coupled with the ReSwift architecture. Obviously, for any project, swapping out your state management system is going to be a pain, no matter how many levels of abstraction you put between it and the view. But it becomes a lot more painful if you also have to unpick it from your view logic. In this case, like I say, I think the above solution would have been fine. In fact, you could even argue that ReSwift would be a good stand-in for FRP libraries like RxSwift or Reactive Cocoa.

But for demonstration purposes I thought I'd add that extra layer of abstraction in. In this project, the AuthVM will catch state updates (as well as dispatching actions). To communicate back to the VM, I am making use of protocols. For a VC to receive state updates from the AuthVM, it must conform to the AuthListener protocol, which has 3 functions:

```swift
func userAuthorised(uid: String)
func userNotLoggedIn()
func userLoginErrored(error: Error)
```
So we now have the following structure:

- **Controllers** - these mostly interact with the APIs and third party libraries.
- **Actions** - These are blocks of code that wrap around the controllers and process any responses into the form of a state change, then dispatch that state change.
- **Reducers** - these catch actions (and their results) and update the state directly.
- **ViewModels** - these subscribe to the store, listening for any updates to the state and dispatching actions when the user interacts with the view.
- **Protocols** - acting as the feedback bridge between VC and the VM, meaning that state updates can be properly communicated to the VC (without the VC explicitly asking for them).
- **View controllers** - the controllers of the view, period. (Finally!).

For sake of clarity, I'm now going to repeat the same list, in the context of my Todo app:

- **FirebaseAuthController** - Takes the users token and authorises with Firebase.
- **Actions_Auth.authoriseWithAccessToken (function)** - Calls FirebaseAuthController with the token, and dispatches either an ShowAuthError action (which contains the error) or a SetUser action (with the user returned by FirebaseAuthController)
- **authReducer** - Catches either the SetUser action or the ShowAuthError action and sets their results to the state.
- **AuthVM** - Catches the state updates emitted by the ReSwift store, updates it's local state, and emits that to it's AuthListener (depending on the result).
- **AuthListener** - assuming the user is logged in, *userAuthorised(uid: String)* will be called.
- **AuthViewController** - conforms to AuthListener (and therefore has implemented *userAuthorised(uid: String)*) and segues to the home page if the authorisation is successful.
