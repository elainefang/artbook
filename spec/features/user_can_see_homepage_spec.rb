require 'spec_helper'

describe 'User can see a homepage' do

  it 'has the title Artbook' do
    visit root_path
    expect(page).to have_content 'Artbook'
  end

end
