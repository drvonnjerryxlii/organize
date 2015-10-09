- - -
> ## Problem Statement
- - -

Ada staff are currently using a combination of Google Apps to keep track of volunteer information, a system which involves manually passing messages between apps and which may become unwieldy as Ada continues to grow.

The goal of this project is to increase volunteer involvement by
- making it easier to schedule volunteer time,
- promoting more volunteer opportunities, and
- improving the overall volunter experience.

- - -
> ## Market Research
- - -

### Competition

There are many products already on the market for managing and scheduling people. Popular systems include paper calendaring, timecards, and native and web apps such as Microsoft Outlook, Google Apps, and a myriad of other human resources, payroll, and people management software suites.

Non-electronic tools for managing volunteers include a large number of pieces of paper, which must be kept organized with lots and lots of filing. For reporting purposes, these tools are cumbersome and in many cases involve duplicating hard copy information in an electronic environment. Since non-profit organizations may be obligated to track volunteer hours as part of fulfilling their public support requirements, a paper system is not ideal for Ada Developers Academy.

The strongest competition for scheduling is Microsoft Outlook, which has a great interface for scheduling people within specific user groups that automatically make available to the group at large free/busy information. Outlook is not an ideal solution for Ada's volunteer scheduling needs, since scheduling is less about finding the right time for several people with conflicting schedules to meet and more about finding a time the volunteer can step aside from their job share knowledge with the Ada students, whose daily schedules are completely at the mercy of Ada staff.

### Differentiation

Google Apps are already available to non-profit organzations free of charge. This product will join the Google Apps together into a more unified suite of tools, taking over the process of passing messages between them and displaying the data in a central, easily accessible location. Additionally, it will standardize notification options for both volunteer and admin users and will provide a central location for special messages, like last-minute requests, to be displayed.


- - -
> ## User Personas
- - -

- __Prospective Volunteers__:
  These users are people who are exploring the idea of sharing their skills and expertise with Ada. They may know someone who is already involved in the organization, or they may be completely new to the organization. They may not be sure how much time they want to commit, and they may not know what opportunities are available. They need to access information about what kinds of volunteers are needed and about how to get involved or sign up.

- __Volunteers__:
  These users are people who are interested in helping out and sharing their subject matter expertise. They need to know when they are scheduled in the classroom (or elsewhere), and they need to know when holidays and other breaks will disrupt regular shifts. Volunteers who are working with students need to know what the students are working on, and they may need to cancel shifts on occasion.

- __Administrators__:
  These users are people who are coordinating with volunteers and working with them in the classroom. Some administrators may be full time volunteer coordinators. They need to access and update information about the volunteers as painlessly as possible. Other administrators may be full time instructors. They need to know how many volunteers will be in the classroom and for what purpose. Administrators of both inclinations may need to adjust volunteer needs or request additional information from them.

<!------------------------------------------------------------------------------
See also the user stories on [this project's Trello board](#).
------------------------------------------------------------------------------->

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


2. __Wave 1: Integrating Google Apps Part 1__ due 10/23, prefer done by 10/20
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
  - pull in or otherwise integrate adadevelopersacademy.wiki


5. __Nice To Haves__: <-- bonus awesome
  - as volunteer experience level grows, admin can change to auto-accept shift requests

<!--
    - requesting shifts
      - different user levels, some get auto-accepted
-->
