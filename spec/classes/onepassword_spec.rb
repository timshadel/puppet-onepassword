require 'spec_helper'

describe 'onepassword' do

  it do
    should contain_package('1Password').with({
      :provider => 'compressed_app',
    })

    should contain_file('chrome_extensions_dir').with_ensure('directory')
    should contain_file('onepassword_chrome_extension').with_ensure('present').with_source('puppet:///modules/onepassword/chrome.json')
  end

end