require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations name' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end
  describe 'validations username' do
    it { should validate_presence_of(:user_name) }
    it { should validate_uniqueness_of(:user_name).case_insensitive }
    it { should validate_length_of(:user_name).is_at_least(6) }
    it { should validate_length_of(:user_name).is_at_most(16) }
    it { should allow_value("zen123").for(:user_name) }
    it { should_not allow_value("foo@barssssssssssss").for(:user_name) }
    it { is_expected.to allow_value("emailadresru").for(:user_name) }
    it { is_expected.not_to allow_value("foo@barssssssssss").for(:user_name) }
  end

  describe 'validations email' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should allow_value("email@address.com").for(:email) }
    it { should_not allow_value("foo@bar").for(:email) }
    it { is_expected.to allow_value("email@adres.ru").for(:email) }
    it { is_expected.not_to allow_value("foo@bar").for(:email) }
  end

  describe 'validations password' do
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_length_of(:password).is_at_most(20) }
  end
end
