- - -
> ### full calendar
- - -

overview
* [bookmarks](#bookmarks)
* [display](#display)
* [events](#events)

- - -
> ### bookmarks
- - -

* http://fullcalendar.io/docs/event_data/lazyFetching/
* events
  * http://fullcalendar.io/docs/event_data/events_json_feed/
  * http://fullcalendar.io/docs/event_data/events_array/
  * http://fullcalendar.io/docs/event_data/Event_Object/
  * http://fullcalendar.io/docs/event_data/Event_Source_Object/
  * click & drag
    http://fullcalendar.io/docs/event_ui/
    * http://fullcalendar.io/docs/event_ui/editable/
    * event drop:
      triggered when dragging stops and the event has moved to a different day/time
      http://fullcalendar.io/docs/event_ui/eventDrop/
    * event resize:
      triggered when resizing stops and the event has changed in duration
      http://fullcalendar.io/docs/event_ui/eventResize/

<div align="right">^<a href="#questions-overview">top</a></div>

- - -
> ### display
- - -

headers
- if you put a comma and no space between buttons in the headers, you get a joined / pill-style button
- if you put a space (regardless of commas), you get separate buttons

<div align="right">^<a href="#questions-overview">top</a></div>

- - -
> ### events
- - -

required attributes:
- title
- start

optional attributes:
- id string/integer
  __different instances of repeating events should all have the same id__
- url string
  __a URL that will be visited when this event is clicked by the user__

optional display attributes:
- color (sets background & border)
- backgroundColor
- borderColor
- textColor

optional scheduling attributes:
- allDay true/false
- overlap true/false
  (specifies whether event can be dragged & dropped over other events, also
  affects other events being dropped in overlapping position)

<div align="right">^<a href="#questions-overview">top</a></div>
