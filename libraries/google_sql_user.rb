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

# A provider to manage Cloud SQL resources.
class SQLUser < GcpResourceBase
  name 'google_sql_user'
  desc 'User'
  supports platform: 'gcp'

  attr_reader :params
  attr_reader :host
  attr_reader :name
  attr_reader :instance
  attr_reader :password

  def initialize(params)
    super(params.merge({ use_http_transport: true }))
    @params = params
    fetched = @connection.fetch(product_url(params[:beta]), resource_base_url, params, 'Get')
    @fetched = unwrap(fetched, params)
    parse unless @fetched.nil?
  end

  def identity
    %w{name host}
  end

  def collection_item
    'items'
  end

  def unwrap(fetched, params)
    fetched[collection_item].find { |result| identity.all? { |id| result[id] == params[id.to_sym] } }
  end

  def parse
    @host = @fetched['host']
    @name = @fetched['name']
    @instance = @fetched['instance']
    @password = @fetched['password']
  end

  def exists?
    !@fetched.nil?
  end

  def to_s
    "User #{@params[:database]}"
  end

  private

  def product_url(_ = nil)
    'https://www.googleapis.com/sql/v1beta4/'
  end

  def resource_base_url
    'projects/{{project}}/instances/{{database}}/users'
  end
end
