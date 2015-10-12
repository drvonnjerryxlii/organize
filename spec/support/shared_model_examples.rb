# TODO: reminder that in rspec you can match arrays: expect(collection.to_a).to match_array([1, 2])


# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of required field symbols
# here is an example call:
# it_behaves_like "a model class with required fields", :broadcast, [:title, :description]
RSpec.shared_examples "a model class with required fields" do |factory, required_fields|
  describe "an instance" do
    required_fields.each do |field|
      it "can't have a null value in #{ field }" do
        valid_instance = create factory
        expect(valid_instance).to be_valid
        expect(valid_instance.errors.keys).not_to include(field)

        # create
        invalid_instance = build factory, field => nil
        invalid_instance.save
        expect(invalid_instance).not_to be_valid
        expect(invalid_instance.errors.keys).to include(field)

        # update
        another_invalid_instance = create factory
        another_invalid_instance[field] = nil
        another_invalid_instance.save
        expect(another_invalid_instance).not_to be_valid
        expect(another_invalid_instance.errors.keys).to include(field)
      end
    end
  end
end

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
      invalid_instance = build factory, field => "one"
      invalid_instance.save
      expect(invalid_instance).not_to be_valid
      expect(invalid_instance.errors.keys).to include(field)

      # update
      another_invalid_instance = create factory, field => 1
      another_invalid_instance[field] = "one"
      another_invalid_instance.save
      expect(another_invalid_instance).not_to be_valid
      expect(another_invalid_instance.errors.keys).to include(field)
    end
  end
end

# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of text field tuples (key: field; value: limit as integer)
# here is an example call:
# it_behaves_like "text fields w/ limits", :note, [{title: 50}, {description: 500}]
RSpec.shared_examples "text fields w/ limits" do |factory, text_fields|
  text_fields.each do |field_tuple|
    field = field_tuple.keys.pop
    limit = field_tuple[field]

    it "can't have a #{ field } that's over #{ limit } characters" do
      valid_instance = create factory, field => "a" * limit
      expect(valid_instance).to be_valid
      expect(valid_instance.errors.keys).not_to include(field)

      # create
      invalid_instance = create factory, field => "a" * (limit + 1)
      invalid_instance.save
      expect(invalid_instance).not_to be_valid
      expect(invalid_instance.errors.keys).to include(field)

      # update
      another_invalid_instance = create factory
      another_invalid_instance[field] = "a" * (limit + 1)
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
