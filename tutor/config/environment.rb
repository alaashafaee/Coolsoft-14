# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Tutor::Application.initialize!

#paginate
require 'will_paginate'

#link detection
require 'metainspector'