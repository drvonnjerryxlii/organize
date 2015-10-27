[![Code Climate](https://codeclimate.com/repos/562aaaa2e30ba0268600167e/badges/cecbf42982df6abc5ae7/gpa.svg)](https://codeclimate.com/repos/562aaaa2e30ba0268600167e/feed)

<!--
- add panel to forms
-->

- - -
> ## Setup
- - -


### Google Calendar API

1. Add Google services (server to server) credentials to your project.
2. Download the p12 version of your private key.
3. [Decrypt the key and store it in your ENV variables.][heroku_private_key]
4. Grab your issuer ID and store it in your ENV variables.
5. Share all relevant calendars with your service account's email address.
   - Give read and write access!
   - Super annoying & worth writing a utility.

### Google OAuth2

1. Add Google OAuth2 credentials to your project.
2. Add https://{insert_your_domain_here}/auth/google_oauth2/callback to your callbacks.
3. Store the client ID and secret in your ENV variables.

[heroku_private_key]: http://ar.zu.my/how-to-store-private-key-files-in-heroku/


### Github OAuth2

1. Add Github credentials to your project.
2. Add https://{insert_your_domain_here}/auth/github/callback to your callbacks.
3. Store the client ID and secret in your ENV variables.

### Postgres

This app is configured to work with Postgres and takes advantage of the citext datatype. You may need to install Postgres or adjust the code that handles case-insensitive text if Postgres is not the right database for your installation.

You may need to explicitly enable citext (`CREATE EXTENSION citext;`).


<!--

- test suite setup:
  - create a dummy calendar & store its ID in your .env

## Nice to haves
- welcome email
- reset password
- volunteer agreement integration

## Must haves
- mailer
  - welcome email
  - shift auto emeail
- green specs
  - chef says: test the happy path / what you're going to demo -- the path of no errors
- display calendar
  - ~~edit calendar things~~
- scheduling jobs
- running jobs

## Next week

- deploy to heroku
- setup ssl
- setup jobs

- - -
> ## Overview
- - -

- [Problem Statement](#problem-statement)
- [Market Research & Insights](#market-research)
  - [Competition](#competition)
  - [Differentiation](#differentiation)
- [User Personas](#user-personas)
- [Product Specifications](#product-specifications)
  - [Deliverables](#deliverables)
  - [Links to Resources](#resources)

- - -
> ## Problem Statement
- - -

Ada staff are currently using a combination of Google Apps to keep track of volunteer information, a system which involves manually passing messages between apps and which may become unwieldy as Ada continues to grow.

The goal of this project is to increase volunteer involvement by
- making it easier to schedule volunteer time,
- promoting more volunteer opportunities, and
- improving the overall volunter experience.

<div align="right">^<a href="#overview">top</a></div>

- - -
> ## Market Research
- - -

This analysis is informed by several informal user research interviews with volunteer coordinators, both inside and outside of the Ada organization; some Ada staff members; Ada volunteers including regular TAs, guest lecturers, and special capstone volunteers; and a few expert Outlook users. These interviews may have been affected by personal biases including my experiences as a long time volunteer and as a former non-profit board member and volunteer organizer & my lack of experience with performing user research.

Once the minimum viable product is complete, I intend to perform a second round of interviews -- this time incorporating usability tests. The feedback from this round of interviews will inform the remainder of development. Further rounds of usability interviews will be incorporated as necessary to ensure product meets user needs and effects of bias are minimized.


### Competition

There are many products already on the market for managing and scheduling people. Popular systems include paper calendaring, timecards, and native and web apps such as Microsoft Outlook, Google Apps, and a myriad of other human resources, payroll, and people management software suites.

Non-electronic tools for managing volunteers include a large number of pieces of paper, which must be kept organized with lots and lots of filing. For reporting purposes, these tools are cumbersome and in many cases involve duplicating hard copy information in an electronic environment. Since non-profit organizations may be obligated to track volunteer hours as part of fulfilling their public support requirements, a paper system is not ideal for Ada Developers Academy.

The strongest competition for scheduling is Microsoft Outlook, which has a great interface for scheduling people within specific user groups that automatically make available to the group at large free/busy information. Outlook is not an ideal solution for Ada's volunteer scheduling needs, since scheduling is less about finding the right time for several people with conflicting schedules to meet and more about finding a time the volunteer can step aside from their job share knowledge with the Ada students, whose daily schedules are completely at the mercy of Ada staff.


### Differentiation

Google Apps are already available to non-profit organzations free of charge. This product will join the Google Apps together into a more unified suite of tools, taking over the process of passing messages between them and displaying the data in a central, easily accessible location. Additionally, it will standardize notification options for both volunteer and admin users and will provide a central location for special messages, like last-minute requests, to be displayed.

<div align="right">^<a href="#overview">top</a></div>


- - -
> ## User Personas
- - -


- __Prospective Volunteers__:
  These users are people who are exploring the idea of sharing their skills and expertise with Ada. They may know someone who is already involved in the organization, or they may be completely new to the organization. They may not be sure how much time they want to commit, and they may not know what opportunities are available. They need to access information about what kinds of volunteers are needed and about how to get involved or sign up.

- __Volunteers__:
  These users are people who are interested in helping out and sharing their subject matter expertise. They need to know when they are scheduled in the classroom (or elsewhere), and they need to know when holidays and other breaks will disrupt regular shifts. Volunteers who are working with students need to know what the students are working on, and they may need to cancel shifts on occasion.

- __Administrators__:
  These users are people who are coordinating with volunteers and working with them in the classroom. Some administrators may be full time volunteer coordinators. They need to access and update information about the volunteers as painlessly as possible. Other administrators may be full time instructors. They need to know how many volunteers will be in the classroom and for what purpose. Administrators of both inclinations may need to adjust volunteer needs or request additional information from them.

<div align="right">^<a href="#overview">top</a></div>


- - -
> ## Product Specifications
- - -

### Deliverables

1. __Baseline / Prototype__ due wed 10/14, prefer done by tue 10/13:
  - provide a base for
    - signup, login, view/update profile (CRUD users)
    - adding notes to users (CRUD notes)
    - storing messages for display (CRUD broadcasts)
    - adding categories to users, broadcasts (CRUD categories)
    - storing / caching calendar event info (CRUD events)
  - OAuth dev strategy for admin users


2. __Wave 1: Integrating Google Apps Part 1__ due fri 10/23, prefer done by sun 10/18
  - integrate Google Calendar with CRUD events
  - integrate FullCalendar.io or own custom display with gCal
    - volunteer vs admin view
    - request a shift, accept a shift
  - add volunteer agreement to user signup process


4. __Wave 2: Integrating Notifications & OAuth__ <-- really what makes product awesome
  - GitHub OAuth for volunteer users
    - hello, ~~world~~ minimum viable product!
      - this means it's time to start planning user testing
  - sending email notifications
    - iCal, gCal attachments
  - notification preferences for users
  - Twitter OAuth for volunteer users
    - Tweet this broadcast
  - __you can has user testing now__


3. __Wave 3: Integrating Google Apps Part 2__
  - integrate Google Forms
    - linking results to events or other database records
  - pull in or otherwise integrate adadevelopersacademy.wiki


5. __Nice To Haves__: <-- bonus awesome
  - as volunteer experience level grows, admin can change to auto-accept shift requests
  - Twilio SMS notifications
  - _no login required_ url access tokens interface for volunteer shift requests & cancellations
  - admin alert messages that display when users log into volunteer portal
    - optional confirm before redirecting / displaying dashboard

### Resources

- [User Stories (Trello board)][trello]

bookmarks for future me:
- [fullcalendar.io](http://fullcalendar.io) ([doc notes](notes/fullcalendar_notes.md))
  - [moment.js](http://momentjs.com/docs/)
- [epiceditor](http://oscargodson.github.io/EpicEditor)

other useful things:
- [google developers console](https://console.developers.google.com/)
- [the trello board][trello]
- [wip product plan](notes/product_plan.md)
- [wip features list](notes/features.md)

[trello]: https://trello.com/b/ZLYgc2TU/jari-capstone

- [wip prototype specs](https://docs.google.com/document/d/1mQprIVP-J1y6J8KxXg7lsn4uuogzb7og-dW1_j4l9sg/edit?usp=sharing)

<div align="right">^<a href="#overview">top</a></div>

- - -
- - -
- - -
product plan - readme barrier
- - -
- - -
- - -

- - -
> ### Integration Choices
- - -

- Background/Async Jobs (sending emails, confirming registrations)
- Third-party OAuth (logging in w/ Twitter, Github, etc.)
- _NoSql (MongoDB)_ ?
- _Front-end Framework (Ember, Angular, Backbone, etc.)_ ?

- - -
> ### Advanced Feature Choices
- - -

- Internationalization (i18n)
- _Service Oriented Architecture (SOA)_ ?
- _Secure Socket Layer (SSL)_ ?
- _Live Events (notifications, live updates, think back to Philip's AWS presentation)_ ?

-->
