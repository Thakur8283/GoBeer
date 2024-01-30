# GoBeer
GoBeer will show the list of beers and its details.

GoBeer is a sample iOS App developed in order to utilize the public APIs for Beers and display a list of all beer. 
User can view list of Beers and also can view their beer details . 
This app also provides the details for the beer such as Beer Tagline, Deescription,Volume and its alcohal content(Alcohol by Volume).

Use cases:
- To display list of all Beers and show details once selected.

APIs integrated(Public APIs):
- https://api.punkapi.com/v2/beers

Licenses and credit details:
- https://punkapi.com/documentation/v2

Project Architectural Details:
- This application follows MVVM architecture with Protocol Oriented Programming(POP).
- APIClient/ NetworkClient is written to handle the network calls.
- Beer module has different layes as per MVVM architecture.
- Image caching done using iOS native caching mechanism.
- Data binding is done using native Combine framework using property observers. 
- Module level API Service layer is also written in order to segregate the load and to introduce scope of test cases.
- Mock API service is also used to mock the success/ failure scenarios.
- Test cases are also written and executed.
- ViewModel layer test cases are done with mock responses and mock errors.
- Mock Beer Test object is created in order to perform test scenarios.


![IMG_3814](https://user-images.githubusercontent.com/4252998/188264545-ce3b0813-dccf-44e9-a1da-9d9776680462.PNG)
![IMG_3815](https://user-images.githubusercontent.com/4252998/188264547-7a564499-36ee-4faa-bf69-f49390e297b1.PNG)
![IMG_3816](https://user-images.githubusercontent.com/4252998/188264551-a7fe38e4-9882-4e04-b5de-e4810ca68385.PNG)

Reach out to me @:

deepak.rana.hp@gmail.com/+91-9888291933
