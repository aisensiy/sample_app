require 'spec_helper'

describe "MicropostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost create" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end

    end

    describe "with valid information" do
      before { fill_in "micropost_content", with: "LLLL" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end


  end

  describe "micropost destroy" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe 'with correct user' do
      before { visit root_path }
      it 'should delete a post' do
        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
      end
    end

    # describe 'with incorrect user' do
    #   before do
    #     sign_in FactoryGirl.create(:user)
    #     delete micropost_path(micropost)
    #   end

    #   specify { response.should redirect_to(root_path) }
    # end
  end

end
