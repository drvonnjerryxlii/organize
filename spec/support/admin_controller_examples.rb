require 'support/shared_controller_examples'

RSpec.shared_examples "admin-only resource controller" do |options_hash|
  # FIXME: needs documentation for set up for using this shared example

  factory = options_hash[:factory]
  class_plural = factory.to_s.pluralize.to_sym
  # OPTIMIZE: the next line will be wrong if factory name ends in s; eg, this -> thi, bus -> bu, lens -> len
  class_name = factory.to_s.classify.constantize
  valid_params = options_hash[:valid_params]
  invalid_params = options_hash[:invalid_params]
  update_params = options_hash[:update_params]
  non_admin_users = [:student, :volunteer]

  # NOTE: we can't use a factory for this, because it's not possible to build or
  # create or really use factories outside of it or before blocks. ;_;
  # if admin_user is attributes_for :admin, we get the following error:
  # `method_missing': `valid_params` is not available on an example group (e.g.
  # a `describe` or `context` block). It is only available from within
  # individual examples (e.g. `it` blocks) or from constructs that run in the
  # scope of an example (e.g. `before`, `let`, etc).
  # (RSpec::Core::ExampleGroup::WrongScopeError)
  admin_user = Admin.create(
    password_digest: "potato face",
    email: "shark#{ Time.now.to_i }#{ rand(100) }@potato.bob",
    name: "shark potato bob",
    type: "Admin"
  )

  valid_session = { user_id: admin_user.id }

  describe "GET #index" do
    template = "index"

    context "for qualified (admin) users" do
      it "assigns all #{ class_plural } as @#{ class_plural }" do
        instance = create factory
        get template, {}, valid_session
        expect(assigns(class_plural)).to include(instance)
      end
    end

    context "for all other users" do
      context "unauthenticated / guest users" do
        it "does not assign all #{ class_plural } as @#{ class_plural }" do
          instance = create factory
          get template, {}
          expect(assigns(class_plural)).to be_nil
        end

        # it_behaves_like "a redirect to the home page" # FIXME: fix this test set
      end

      context "authenticated users" do
        non_admin_users.each do |user_type|
          it "does not assign all #{ class_plural } as @#{ class_plural }" do
            instance = create factory
            user = create user_type
            get template, {}, { user_id: user.id }
            expect(assigns(class_plural)).to be_nil
          end

          # it_behaves_like "a redirect to the home page" # FIXME: fix this test set
        end
      end
    end

    it_behaves_like "a 200 response only for admin users", template, factory
  end

  describe "GET #show" do
    template = "show"

    context "for qualified (admin) users" do
      it "assigns the requested #{ factory } as @#{ factory }" do
        instance = create factory
        get template, { id: instance.id }, valid_session
        expect(assigns(factory)).to eq(instance)
      end
    end

    it_behaves_like "a 200 response only for admin users", template, factory
  end

  describe "GET #new" do
    template = "new"

    context "for qualified (admin) users" do
      it "assigns a new #{ factory } as @#{ factory }" do
        get :new, {}, valid_session
        expect(assigns(factory)).to be_a_new(class_name)
      end
    end

    it_behaves_like "a 200 response only for admin users", template, factory
  end

  describe "GET #edit" do
    template = "edit"
    factory = factory

    context "for qualified (admin) users" do
      it "assigns the requested #{ factory } as @#{ factory }" do
        instance = create factory
        get :edit, { id: instance.id }, valid_session
        expect(assigns(factory)).to eq(instance)
      end
    end

    it_behaves_like "a 200 response only for admin users", template, factory
  end

  describe "POST #create" do
    context "for qualified (admin) users" do
      context "with valid params" do
        it "creates a new #{ class_name }" do
          expect {
            post :create, valid_params, valid_session
          }.to change(class_name, :count).by(1)
        end

        it "assigns a newly created #{ factory } as @#{ factory }" do
          post :create, valid_params, valid_session
          expect(assigns(factory)).to be_a(class_name)
          expect(assigns(factory)).to be_persisted
        end

        it "redirects to the created #{ factory }" do
          post :create, valid_params, valid_session
          expect(response).to redirect_to(class_name.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved #{ factory } as @#{ factory }" do
          post :create, invalid_params, valid_session
          expect(assigns(factory)).to be_a_new(class_name)
        end

        it "re-renders the 'new' template" do
          post :create, invalid_params, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    context "for all other users" do
      context "unauthenticated / guest users" do
        it "does not create a new #{ class_name }" do
          expect {
            post :create, valid_params
          }.to change(class_name, :count).by(0)
        end

        # it_behaves_like "a redirect to the login page" # FIXME: broken test
      end

      context "authenticated users" do
        # it_behaves_like "a redirect to the home page" # FIXME: broken test
      end
    end
  end

  describe "PUT #update" do
    context "for qualified (admin) users" do
      context "with valid params" do
        it "updates the requested #{ factory }" do
          instance = create factory
          put :update, { id: instance.id, factory => update_params }, valid_session
          instance.reload
          expect(instance[factory]).to eq(update_params[factory])
        end

        it "assigns the requested #{ factory } as @#{ factory }" do
          instance = create factory
          put :update, { id: instance.id, factory => update_params }, valid_session
          expect(assigns(factory)).to eq(instance)
        end

        it "redirects to the #{ factory }" do
          instance = create factory
          put :update, { id: instance.id, factory => update_params }, valid_session
          expect(response).to redirect_to(instance)
        end
      end

      context "with invalid params" do
        it "assigns the #{ factory } as @#{ factory }" do
          instance = create factory
          put :update, { id: instance.id, factory => invalid_params }, valid_session
          expect(assigns(factory)).to eq(instance)
        end

        it "re-renders the 'edit' template" do
          instance = create factory
          put :update, { id: instance.id, factory => invalid_params }, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    # context "for all other users" do
    #   context "unauthenticated / guest users" do
    #     it "does not update the #{ factory }" do
    #       instance = create factory
    #       expect {
    #         put :update, { id: instance.id, factory => update_params }
    #       }.to change(class_name, :count).by(0)
    #     end
    #
    #     it_behaves_like "a redirect to the login page"
    #   end
    #
      # context "authenticated users" do
      #   non_admin_users.each do |user_type|
      #     unless user_type == :admin
      #       before :each do
      #         instance = create factory
      #         user = create user_type
      #         put :update, { id: instance.id, factory => update_params }, { user_id: user.id }
      #       end
      #       it_behaves_like "a redirect to the home page"
      #     end
      #   end
      # end
    # end # FIXME: these specs are broken by the redirect test, same as below
  end

  describe "DELETE #destroy" do
    context "for qualified (admin) users" do
      it "destroys the requested #{ factory }" do
        instance = create factory
        expect {
          delete :destroy, { id: instance.id }, valid_session
        }.to change(class_name, :count).by(-1)
      end

      it "redirects to the #{ class_plural } list" do
        instance = create factory
        delete :destroy, { id: instance.id }, valid_session
        all_path = class_plural.to_s # eg, :note -> "note" -> "notes", :category -> "category" -> "categories"
        all_path += "_path" # eg "notes" -> "notes_path", "categories" -> "categories_path"
        all_path = eval(all_path) # eg "notes_path" -> notes_path, "categories_path" -> categories_path
        expect(response).to redirect_to(all_path)
      end
    end

    context "for all other users" do
      context "unauthenticated / guest users" do
        it "does not delete the #{ factory }" do
          instance = create factory
          expect {
            delete :destroy, { id: instance.id }
          }.to change(class_name, :count).by(0)
        end

        # it_behaves_like "a redirect to the login page" # FIXME: fix this test set
      end

      context "authenticated users" do
        non_admin_users.each do |user_type|
          it "does not delete the #{ factory }" do
            instance = create factory
            user = create user_type
            expect {
              delete :destroy, { id: instance.id }, { user_id: user.id }
            }.to change(class_name, :count).by(0)
          end

          # it_behaves_like "a redirect to the home page" # FIXME: fix this test set
        end
      end
    end
  end
end
