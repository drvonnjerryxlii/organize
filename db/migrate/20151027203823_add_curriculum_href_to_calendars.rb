class AddCurriculumHrefToCalendars < ActiveRecord::Migration
  def change
    add_column :calendars, :curriculum_href, :string
  end
end
