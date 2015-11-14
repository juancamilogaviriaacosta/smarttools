# Be sure to restart your server when you modify this file.

require 'dalli'

#Rails.application.config.session_store :cookie_store, key: '_smarttools_session'
Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 1.day
