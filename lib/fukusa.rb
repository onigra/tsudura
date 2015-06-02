require "thor"
require "aws-sdk"
require 'base64'
require "yaml"
require 'date'
require "fileutils"
require "open3"
require "active_support"
require "active_support/core_ext"
require "awesome_print"

require "fukusa/aws/ami"
require "fukusa/aws/auto_scale"
require "fukusa/aws/launch_config"
require "fukusa/aws/launch_instance"

require "fukusa/provisioner/ansible"

require "fukusa/config_parser"
require "fukusa/runner"
require "fukusa/cli"

require "fukusa/version"

module Fukusa
  # Your code goes here...
end
