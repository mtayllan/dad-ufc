# frozen_string_literal: true

require 'ferrum'
require 'json'
require 'cgi'

def handler(event:, context:)
  html = CGI.unescape_html(event['html'])
  browser = Ferrum::Browser.new(browser_options: { 'no-sandbox': nil })
  browser.frames.first.set_content(html)
  base64 = browser.screenshot(full: true)
  { data: base64 }
end
