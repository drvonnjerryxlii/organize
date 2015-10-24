FactoryGirl.define do
  factory :category do |cat|
    cat.sequence(:name) { |n| "sharktastic #{ n }" }
  end

  factory :default_cat do
    name rand(5000)
    color "black"
    admin_only false
    hidden true
    approved true

    factory :category_without_color do
      color nil
    end

    factory :category_without_admin_only do
      admin_only nil
    end

    factory :category_without_hidden do
      hidden nil
    end

    factory :category_without_approved do
      approved nil
    end
  end
end
