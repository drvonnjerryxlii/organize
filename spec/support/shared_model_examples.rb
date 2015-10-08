# TODO: reminder that in rspec you can match arrays: expect(collection.to_a).to match_array([1, 2])


# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of required fields
# here is an example call:
# it_behaves_like "a model class with required fields", :broadcast, [:title, :short_description]
RSpec.shared_examples "a model class with required fields" do |factory, required_fields|
  describe "an instance" do
    required_fields.each do |field|
      it "cannot be instantiated without a #{ field }" do
        instance = create factory, field => nil
        # instance = build factory, field => nil
        # instance.save
        expect(instance).not_to be_valid
        expect(instance.errors.keys).to include(field)
      end
    end
  end
end

# this shared example needs two parameters to be passed in when called:
#    1. a model factory
#    2. an array of optional fields
# here is an example call:
# it_behaves_like "a model class with optional fields", :note, [:title, :short_description]
RSpec.shared_examples "a model class with optional fields" do |factory, optional_fields|
  describe "an instance" do
    optional_fields.each do |field|
      it "can be instantiated without a #{ field }" do
        instance = create factory, field => nil
        # instance = build factory, field => nil
        # instance.save
        expect(instance).to be_valid
        expect(instance.errors.keys).not_to include(field)
      end
    end
  end
end
