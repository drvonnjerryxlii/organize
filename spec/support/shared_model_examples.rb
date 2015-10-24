# TODO: reminder that in rspec you can match arrays: expect(collection.to_a).to match_array([1, 2])
# TODO: test uniqueness
# FIXME: test defaults? maybe w/ special factories missing defaults? >_<
# TODO: test relationships? http://blog.davidchelimsky.net/blog/2012/02/12/validations-are-behavior-associations-are-structure/
# FIXME: update numericality tests after shoulda-matchers gets to 3.0.1 per closed issue #801 https://github.com/thoughtbot/shoulda-matchers/issues/801 (currently broken for number columns)

# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of optional field symbols
# here is an example call:
# it_behaves_like "a model class with optional fields", :note, [:title, :description]
RSpec.shared_examples "a model class with optional fields" do |factory, optional_fields|
  describe "an instance" do
    optional_fields.each do |field|
      it "can have a null value in #{ field }" do
        valid_instance = create factory
        expect(valid_instance).to be_valid
        expect(valid_instance.errors.keys).not_to include(field)

        also_valid_instance = create factory, field => nil
        expect(also_valid_instance).to be_valid
        expect(also_valid_instance.errors.keys).not_to include(field)
      end
    end
  end
end

# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of integer field symbols
# here is an example call:
# it_behaves_like "numeric integer fields", :note, [:title, :description]
RSpec.shared_examples "numeric integer fields" do |factory, integer_fields|
  integer_fields.each do |field|
    it "can't have a #{ field } with a non-integer value" do
      valid_instance = create factory, field => 1
      expect(valid_instance).to be_valid
      expect(valid_instance.errors.keys).not_to include(field)

      # create
      invalid_instance = build factory, field => 1.1
      invalid_instance.save
      expect(invalid_instance).not_to be_valid
      expect(invalid_instance.errors.keys).to include(field)

      # update
      another_invalid_instance = create factory, field => 1
      another_invalid_instance[field] = 1.1
      another_invalid_instance.save
      expect(another_invalid_instance).not_to be_valid
      expect(another_invalid_instance.errors.keys).to include(field)
    end
  end
end

# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of default field tuples (key: field; value: default value)
# here is an example call:
# it_behaves_like "fields w/ default values", :note, [{title: "no subject"}, {description: "nope"}]
RSpec.shared_examples "fields w/ default values" do |factory, default_fields|
  default_fields.each do |field_tuple|
    field = field_tuple.keys.pop
    default = field_tuple[field]

    it "has a default value of #{ default } for #{ field }" do
      default_instance = create factory, field => nil
      expect(default_instance).to be_valid
      expect(default_instance.errors.keys).not_to include(field)
      expect(default_instance[field]).to eq(default)
    end
  end
end
