rails g scaffold user password_digest:text name:text{250} email:text{320}
rails g scaffold oauth user_id:integer provider:text{64} provider_uid:text

db:reset

psql ada_volunteer_portal_development
CREATE EXTENSION citext;

psql ada_volunteer_portal_test
CREATE EXTENSION citext;


users
- db
  - user password_digest:text name:text{250} email:text{320}
  - * null:false except p_digest b/c oauth
- model
  - has_secure_password
  - has and belongs to many events
  - has and belongs to many categories
    - has zero to many broadcasts through categories
  - has zero to many oauth
  - has zero to many guest lecture proposals
  - has zero to many notes
  - has zero to many cohorts

oauth
- db
  - oauth user_id:integer provider:text{64} provider_uid:text
  - * null:false, user_id == foreign key / belongs_to
- model
  - belongs to user

categories
- db
  - category name:text{250}:uniq color:text admin_only:boolean approved:boolean
  - null:false name, admin default true, approved default false
- model
  - has many notes thru category_joins
  - has many broadcasts thru category_joins
  - has many guest lectures thru cat joins
  - has many users thru cat joins
  - has many events thru category joins?
  - has many cats thru cat joins?

category_joins
- db
  - model category_join category_id:integer categorizable_type:integer categorizable_id:integer
  - * null:false
- model
  - belongs_to :categorizable, polymorphic: true
  - belongs_to :category

notes
- db
  - note user_id:integer note:text
  - * null:false, user_id == foreign key / belongs_to
- model
  - belongs to user
  - has_many :category_joins, as: :categorizable
  - has_many :categories, through: :category_joins

guest lectures
- db
  - guest_lecture user_id:integer title:text{50} description{500}
  - * null:false except short_desc, user_id == foreign key / belongs_to
- model
  - same as notes

broadcasts
- db
  - broadcast title:text{50} description:text{500}
  - * null:false
- model
  - same as notes

events
- db
  - event title:text start_time:datetime end_time:datetime google_id:text cohort_id:integer admin_only:boolean
  - * null:false except cohort id & admin only, admin only default false
- model
  - has many event attendees
  - has many users thru event attnds
  - belongs to cohort
  - has many cat joins & many cats thru cat joins?

events attendees
- db
  - migration create_events_attendees event_id:integer user_id:integer
  - id: false, index beide, * null:false

cohorts
- db
  - cohort classroom_start_date:datetime classroom_end_date:datetime internship_start_date:datetime internship_end_date:datetime

cohort users
- db
  - migration create_cohorts_users cohort_id:integer user_id:integer
  - id: false, index beide, * null:false


session
- rails g scaffold_controller session new create destroy
