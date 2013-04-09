# Install 1Password into /Applications
# Install Chrome extension via update URL
#
# Usage:
#
#     include 1password
class onepassword {
  $host = 'd13itkw33a7sus.cloudfront.net'
  $path = 'dist/1P/mac/1Password-3.8.20.zip'

  package { '1Password':
    source   => "https://${host}/${path}",
    provider => 'compressed_app'
  }

  $chrome_dir = "/Users/${::luser}/Library/Application Support/Google/Chrome/External Extensions"

  file { 'chrome_extensions_dir':
    ensure  => directory,
    path    => $chrome_dir,
    mode    => '0755',
    require => [Package['Chrome'],Package['1Password']];
  }

  file { 'onepassword_chrome_extension':
    ensure  => present,
    path    => "${chrome_dir}/gkndfifopckmhdkohjeoljlbfnjhekfg.json",
    source  => 'puppet:///modules/onepassword/chrome.json',
    mode    => '0644',
    require => [Package['Chrome'],Package['1Password'],File['chrome_extensions_dir']];
  }

}
