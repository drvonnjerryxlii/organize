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

broadcasts = CSV.read(file_base + "broadcasts.csv", { headers: true })
broadcasts.each do |broadcast|
  Broadcast.create(
    # active: broadcast["active"], # FIXME: uncomment after seeds updated
    title: broadcast["title"],
    description: broadcast["description"]
  )
end

calendars = CSV.read(file_base + "cohorts.csv", { headers: true })
calendars.each do |calendar|
  c = Calendar.create(
    name: calendar["name"],
    google_calendar_id: calendar["google_calendar_id"]
  )
end

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

guest_lectures = CSV.read(file_base + "guest_lectures.csv", { headers: true })
guest_lectures.each do |guest_lecture|
  GuestLecture.create(
    user_id: guest_lecture["user_id"],
    title: guest_lecture["title"],
    description: guest_lecture["description"]
  )
end

events = CSV.read(file_base + "events.csv", { headers: true })
events.each do |event|
  c = Calendar.find((1..5).to_a.sample)
  e = Event.create(
    title: event["title"],
    start_time: event["start_time"],
    end_time: event["end_time"],
    guest_lecture_id: event["guest_lecture_id"],
    calendar_id: c.id
  )
end

# events_users = CSV.read(file_base + "events_users.csv", { headers: true })
# events_users.each do |event_user|
#   user = User.find(event_user["user_id"])
#   event = Cohort.find(event_user["event_id"])
#   user.events << event unless user.events.include? event
# end

categories = CSV.read(file_base + "categories.csv", { headers: true })
categories.each do |category|
  Category.create(
    name: category["name"],
    hidden: category["hidden"],
    admin_only: category["admin_only"],
    approved: category["approved"]
  )
end

category_joins = CSV.read(file_base + "category_joins.csv", { headers: true })
category_joins.each do |category_join|
  CategoryJoin.create(
    category_id: category_join["category_id"],
    categorizable_id: category_join["categorizable_id"],
    categorizable_type: category_join["categorizable_type"]
  )
end
