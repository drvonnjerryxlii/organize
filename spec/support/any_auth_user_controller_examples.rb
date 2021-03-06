require 'support/shared_controller_examples'

RSpec.shared_examples "any auth user resource controller" do |options_hash|
  # FIXME: needs documentation for set up for using this shared example
  # FIXME: needs handling for single except, only (outside array)
  # FIXME: handling for if both except & only?
  # FIXME: http response code testing

  # Setup ----------------------------------------------------------------------------------------------------
  except = options_hash[:except].map { |e| e.to_s } if options_hash[:except] # in case user passes symbols
  only = options_hash[:only].map { |o| o.to_s } if options_hash[:only] # in case user passes symbols
  do_everything = (except || only) ? false : true # do everything if and only if except && only are both nil
  supported_users = [:admin, :student, :volunteer]


  factory = options_hash[:factory]
  class_plural = factory.to_s.pluralize.to_sym
  # OPTIMIZE: the next line will be wrong if factory name ends in s; eg, this -> thi, bus -> bu, lens -> len
  class_name = factory.to_s.classify.constantize # NOTE: perhaps capitalize instead?

  valid_params = options_hash[:valid_params]
  invalid_params = options_hash[:invalid_params]
  update_params = options_hash[:update_params]


  # Index ----------------------------------------------------------------------------------------------------
  if (only && (only.include? "index")) || (except && !(except.include? "index")) || do_everything
    describe "GET #index" do
      template = "index"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            it "assigns all #{ class_plural } as @#{ class_plural }" do
              instance = create factory
              get template, {}, valid_session
              expect(assigns(class_plural)).to include(instance)
              # FIXME: polymorphism doesn't like this all things include thing
              # Diff:
              # @@ -1,4 +1,20 @@
              # -[#<User:0x007fba8126fc58
              # +[#<Admin:0x007fba882d9598
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not assign all #{ class_plural } as @#{ class_plural }" do
          instance = create factory
          get template, {}
          expect(assigns(class_plural)).to be_nil
        end
      end

      it_behaves_like "a 200 response only for authenticated users", template, factory
    end
  end

  # Show -----------------------------------------------------------------------------------------------------
  if (only && (only.include? "show")) || (except && !(except.include? "show")) || do_everything
    describe "GET #show" do
      template = "show"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            it "assigns the requested #{ factory } as @#{ factory }" do
              instance = create factory
              get template, { id: instance.id }, valid_session
              expect(assigns(factory)).to eq(instance)
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not assign the requested #{ factory } as @#{ factory }" do
          instance = create factory
          get template, { id: instance.id }
          expect(assigns(factory)).to be_nil
        end
      end

      it_behaves_like "a 200 response only for authenticated users", template, factory
    end
  end

  # New ------------------------------------------------------------------------------------------------------
  if (only && (only.include? "new")) || (except && !(except.include? "new")) || do_everything
    describe "GET #new" do
      template = "new"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            it "assigns a new #{ factory } as @#{ factory }" do
              get :new, {}, valid_session
              expect(assigns(factory)).to be_a_new(class_name)
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not assign a new #{ factory } as @#{ factory }" do
          get :new, {}
          expect(assigns(factory)).to be_nil
        end
      end

      it_behaves_like "a 200 response only for authenticated users", template, factory
    end
  end

  # Edit -----------------------------------------------------------------------------------------------------
  if (only && (only.include? "edit")) || (except && !(except.include? "edit")) || do_everything
    describe "GET #edit" do
      template = "edit"
      factory = factory

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            it "assigns the requested #{ factory } as @#{ factory }" do
              instance = create factory
              get :edit, { id: instance.id }, valid_session
              expect(assigns(factory)).to eq(instance)
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not assign the requested #{ factory } as @#{ factory }" do
          instance = create factory
          get :edit, { id: instance.id }
          expect(assigns(factory)).to be_nil
        end
      end

      it_behaves_like "a 200 response only for authenticated users", template, factory
    end
  end

  # Create ---------------------------------------------------------------------------------------------------
  if (only && (only.include? "create")) || (except && !(except.include? "create")) || do_everything
    describe "POST #create" do
      template = "create"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            context "with valid params" do
              it "creates a new #{ class_name }" do
                expect {
                  post template, valid_params, valid_session
                }.to change(class_name, :count).by(1)
              end

              it "assigns a newly created #{ factory } as @#{ factory }" do
                post template, valid_params, valid_session
                expect(assigns(factory)).to be_a(class_name)
                expect(assigns(factory)).to be_persisted
              end

              it "redirects to the created #{ factory }" do
                post template, valid_params, valid_session
                expect(response).to redirect_to(class_name.last)
                # FIXME: polymorphism doesn't like this url helper trigger
                # undefined method `volunteer_url' for #<UsersController:0x007fba8881f048>
              end
            end

            context "with invalid params" do
              it "assigns a newly created but unsaved #{ factory } as @#{ factory }" do
                post template, invalid_params, valid_session
                expect(assigns(factory)).to be_a_new(class_name)
              end

              it "re-renders the 'new' template" do
                post template, invalid_params, valid_session
                expect(response).to render_template("new")
              end
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not create a new #{ class_name }" do
          expect {
            post template, valid_params
          }.to change(class_name, :count).by(0)
        end

        # it_behaves_like "a redirect to the login page" # FIXME: broken test
      end
    end
  end

  # Update ---------------------------------------------------------------------------------------------------
  if (only && (only.include? "update")) || (except && !(except.include? "update")) || do_everything
    describe "PUT #update" do
      template = "update"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            context "with valid params" do
              it "updates the requested #{ factory }" do
                instance = create factory
                put template, { id: instance.id, factory => update_params }, valid_session
                instance.reload
                expect(instance[factory]).to eq(update_params[factory])
              end

              it "assigns the requested #{ factory } as @#{ factory }" do
                instance = create factory
                put template, { id: instance.id, factory => update_params }, valid_session
                expect(assigns(factory)).to eq(instance)
              end

              it "redirects to the #{ factory }" do
                instance = create factory
                put template, { id: instance.id, factory => update_params }, valid_session
                expect(response).to redirect_to(instance)
              end
            end

            context "with invalid params" do
              it "assigns the #{ factory } as @#{ factory }" do
                instance = create factory
                put template, { id: instance.id, factory => invalid_params }, valid_session
                expect(assigns(factory)).to eq(instance)
              end

              it "re-renders the 'edit' template" do
                instance = create factory
                put template, { id: instance.id, factory => invalid_params }, valid_session
                expect(response).to render_template("edit")
              end
            end
          end
        end
      end

      # context "for unauthenticated / guest users" do
      #   context "unauthenticated / guest users" do
      #     it "does not update the #{ factory }" do
      #       instance = create factory
      #       expect {
      #         put template, { id: instance.id, factory => update_params }
      #       }.to change(class_name, :count).by(0)
      #     end
      #
      #     it_behaves_like "a redirect to the login page"
      #   end
      #
      #   context "authenticated users" do
      #     non_admin_users.each do |user_type|
      #       unless user_type == :admin
      #         before :each do
      #           instance = create factory
      #           user = create user_type
      #           put template, { id: instance.id, factory => update_params }, { user_id: user.id }
      #         end
      #         it_behaves_like "a redirect to the home page"
      #       end
      #     end
      #   end
      # end # FIXME: these specs are broken by the redirect test, same as below
    end
  end

  # Destroy --------------------------------------------------------------------------------------------------
  if (only && (only.include? "destroy")) || (except && !(except.include? "destroy")) || do_everything
    describe "DELETE #destroy" do
      template = "destroy"

      context "for qualified (logged in) users" do
        supported_users.each do |user_type|
          let(:user) { create user_type }
          let(:valid_session) { { user_id: user.id } }

          context "for user type: #{ user_type }" do
            it "destroys the requested #{ factory }" do
              instance = create factory
              expect {
                delete template, { id: instance.id }, valid_session
              }.to change(class_name, :count).by(-1)
            end

            it "redirects to the #{ class_plural } list" do
              instance = create factory
              delete template, { id: instance.id }, valid_session
              all_path = class_plural.to_s # eg, :notes -> "notes", :categories -> "categories"
              all_path += "_path" # eg "notes" -> "notes_path", "categories" -> "categories_path"
              all_path = eval(all_path) # eg "notes_path" -> notes_path, "categories_path" -> categories_path
              expect(response).to redirect_to(all_path)
            end
          end
        end
      end

      context "for unauthenticated / guest users" do
        it "does not delete the #{ factory }" do
          instance = create factory
          expect {
            delete template, { id: instance.id }
          }.to change(class_name, :count).by(0)
        end
      end
    end
  end
end
