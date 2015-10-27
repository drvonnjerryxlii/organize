require "csv"
file_base = "#{ Rails.root }/db/seed_files/"

users = CSV.read(file_base + "users.csv", { headers: true })
users.each do |user|
  User.create(
    email: user["email"],
    github: user["github"],
    name: user["name"],
    type: user["type"],
    password: user["password"],
    password_confirmation: user["password"]
  )
end

puts "seeded special users"

# plus we need a bunch of generic students
emails = ["generic", "default", "example"]

first_names = [
  "Adanech", "Amabel", "Anouk", "Caia", "Carmelita", "Cerys", "Eshe",
  "Fan", "Fathiyya", "Finn", "Gzifa", "Jia", "Jifunza", "Lin", "Nasim",
  "Onaedo", "Ryoko", "Seul-gi"
]

last_names = [
  "Arial", "Comic-Sans", "Courier", "Futura", "Garamound", "Georgia",
  "Helvetia", "Impact", "Lucida", "Palatino", "Serif", "Times", "Trebuchet",
  "Verdana", "Wingdings"
]

first_generic_student = User.last.id + 1

(1...100).to_a.each do |n|
  User.create(
    email: "student#{ n }@shark.com",
    github: "#{ emails.sample }#{ n }",
    name: "#{ first_names.sample } #{ last_names.sample }",
    type: "Student",
    password: "password",
    password_confirmation: "password"
  )
end

last_generic_student = User.last.id

puts "seeded generic student users"

broadcasts = CSV.read(file_base + "broadcasts.csv", { headers: true })
broadcasts.each do |broadcast|
  Broadcast.create(
    # active: broadcast["active"], # FIXME: uncomment after seeds updated
    title: broadcast["title"],
    description: broadcast["description"]
  )
end

puts "seeded broadcasts"

calendars = CSV.read(file_base + "cohorts.csv", { headers: true })
calendars.each do |calendar|
  Calendar.create(
    name: calendar["name"],
    google_calendar_id: calendar["google_calendar_id"]
  )
end

puts "seeded calendars"

calendars_users = CSV.read(file_base + "cohorts_users.csv", { headers: true })
calendars_users.each do |calendar_user|
  user = User.find(calendar_user["user_id"])
  calendar = Calendar.find(calendar_user["cohort_id"])
  user.calendars << calendar unless user.calendars.include? calendar
end

notes = CSV.read(file_base + "notes.csv", { headers: true })
notes.each do |note|
  Note.create(
    user_id: note["user_id"],
    note: note["note"]
  )
end

puts "seeded notes"

guest_lectures = CSV.read(file_base + "guest_lectures.csv", { headers: true })
guest_lectures.each do |guest_lecture|
  GuestLecture.create(
    user_id: guest_lecture["user_id"],
    title: guest_lecture["title"],
    description: guest_lecture["description"]
  )
end

puts "seeded guest lectures"

events = CSV.read(file_base + "events.csv", { headers: true })
events.each do |event|
  Event.create(
    title: event["title"],
    start_time: event["start_time"],
    end_time: event["end_time"],
    ta: event["ta"],
    gl: event["gl"],
    guest_lecture_id: event["guest_lecture_id"],
    user_id: event["user_id"],
    calendar_id: event["calendar_id"]
  )
end

puts "seeded special events"

calendars = Calendar.all.map { |c| c.id }
volunteers = Volunteer.all
calendars.each do |cal|
  5.times do |count|
    v = volunteers.sample
    Event.create(
      title: "TA: #{ v.name }",
      start_time: Time.parse("#{ Date.today.at_beginning_of_week + count } 1pm"),
      end_time: Time.parse("#{ Date.today.at_beginning_of_week + count } 5pm"),
      ta: true,
      gl: false,
      user_id: v.id,
      calendar_id: cal
    )
  end
end

puts "seeded generic TA events"

# events_users = CSV.read(file_base + "events_users.csv", { headers: true })
# events_users.each do |event_user|
#   user = User.find(event_user["user_id"])
#   event = Cohort.find(event_user["event_id"])
#   user.events << event unless user.events.include? event
# end
#
categories = CSV.read(file_base + "categories.csv", { headers: true })
categories.each do |category|
  Category.create(
    name: category["name"],
    hidden: category["hidden"],
    admin_only: category["admin_only"],
    topic_related: category["topic_related"],
    user_related: category["user_related"],
    approved: category["approved"]
  )
end

puts "seeded categories"

category_joins = CSV.read(file_base + "category_joins.csv", { headers: true })
category_joins.each do |category_join|
  CategoryJoin.create(
    category_id: category_join["category_id"],
    categorizable_id: category_join["categorizable_id"],
    categorizable_type: category_join["categorizable_type"]
  )
end

students = Student.all
calendars = Calendar.all

students.each do |stud|
  calendar = calendars.sample
  stud.calendars << calendar
  cohort = Category.where("name LIKE ?", "%#{ calendar.name.downcase }%")
  stud.categories << cohort
end

puts "seeded categorizables"
