# frozen_string_literal: false

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------
require 'gcp_backend'
require 'google/sourcerepo/property/repository_pubsub_configs'

# A provider to manage Cloud Source Repositories resources.
class SourceRepoRepository < GcpResourceBase
  name 'google_sourcerepo_repository'
  desc 'Repository'
  supports platform: 'gcp'

  attr_reader :params
  attr_reader :name
  attr_reader :url
  attr_reader :size
  attr_reader :pubsub_configs

  def initialize(params)
    super(params.merge({ use_http_transport: true }))
    @params = params
    @fetched = @connection.fetch(product_url(params[:beta]), resource_base_url, params, 'Get')
    parse unless @fetched.nil?
  end

  def parse
    @name = @fetched['name']
    @url = @fetched['url']
    @size = @fetched['size']
    @pubsub_configs = @fetched['pubsubConfigs']
  end

  def exists?
    !@fetched.nil?
  end

  def to_s
    "Repository #{@params[:name]}"
  end

  private

  def product_url(_ = nil)
    'https://sourcerepo.googleapis.com/v1/'
  end

  def resource_base_url
    'projects/{{project}}/repos/{{name}}'
  end
end
