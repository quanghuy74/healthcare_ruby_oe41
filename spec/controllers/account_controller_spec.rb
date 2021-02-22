
require "rails_helper"

RSpec.describe AccountsController do
  include SessionsHelper

  let!(:account) {FactoryBot.create(:account)}

  before do
    log_in account
  end

  describe "GET #index" do
    it "get all staff" do
      get :index
      expect(Account.staff).to  match_array(@staffs)
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "get an account" do
      get :show, params: {id: account.id}
      expect(assigns(account)).to eq(@account)
    end
  end
  
  describe "GET #new" do
    it "renders the :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "get an account" do
      get :show, params: {id: account.id}
      expect(assigns(account)).to eq(@account)
    end

    it "render the :edit view" do
      get :edit, params: {id: account.id}
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "save the new account in the database" do
        expect{
          post :create, params: {account: FactoryBot.attributes_for(:account)}
        }.to change(Account, :count).by(1)
      end

      it "flash info message" do
        post :create, params: {account: FactoryBot.attributes_for(:account)}
        expect(flash[:info]).to eq(I18n.t "controller.accounts.create.info")
      end

      it "redirects to the home page" do
        post :create, params: {account: FactoryBot.attributes_for(:account)}
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new account in the database" do
        expect{
          post :create, params: {account: FactoryBot.attributes_for(:account, email: "hello")}
        }.to_not change(Account, :count)
      
      end

      it "flash failed message" do
        post :create, params: {account: FactoryBot.attributes_for(:account, email: "hello")}
        expect(flash[:danger]).to eq(I18n.t "controller.accounts.create.danger")
      end

      it "re-renders the :new template" do
        post :create, params: {account: FactoryBot.attributes_for(:account, email: "hello")}
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "update account in the database" do
        post :update, params: {account: FactoryBot.attributes_for(:account), id: account.id}
        expect(assigns(account)).to eq(@account)
      end

      it "flash info message" do
        post :update, params: {account: FactoryBot.attributes_for(:account), id: account.id}
        expect(flash[:success]).to eq(I18n.t "controller.accounts.update.success")
      end

      it "redirects to the home page" do
        post :update, params: {account: FactoryBot.attributes_for(:account), id: account.id}
        expect(response).to redirect_to @account
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new account in the database" do
        expect{
          post :update, params: {account: FactoryBot.attributes_for(:account, email: "hello"), 
                                 id: account.id, id: account.id}
        }.to_not change(Account, :count)
      
      end

      it "flash failed message" do
        post :update, params: {account: FactoryBot.attributes_for(:account, email: "hello"), id: account.id}
        expect(flash[:danger]).to eq(I18n.t "controller.accounts.update.fail")
      end

      it "re-renders the :edit template" do
        post :update, params: {account: FactoryBot.attributes_for(:account, email: "hello"), id: account.id}
        expect(response).to render_template :edit
      end
    end
  end
end
