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
require 'google/compute/property/projectinfo_common_instance_metadata'
require 'google/compute/property/projectinfo_common_instance_metadata_items'
require 'google/compute/property/projectinfo_quotas'

# A provider to manage Compute Engine resources.
class ComputeProjectInfo < GcpResourceBase
  name 'google_compute_project_info'
  desc 'ProjectInfo'
  supports platform: 'gcp'

  attr_reader :params
  attr_reader :name
  attr_reader :common_instance_metadata
  attr_reader :enabled_features
  attr_reader :default_service_account
  attr_reader :xpn_project_status
  attr_reader :default_network_tier
  attr_reader :quotas
  attr_reader :creation_timestamp

  def initialize(params)
    super(params.merge({ use_http_transport: true }))
    @params = params
    @fetched = @connection.fetch(product_url(params[:beta]), resource_base_url, params, 'Get')
    parse unless @fetched.nil?
  end

  def parse
    @name = @fetched['name']
    @common_instance_metadata = GoogleInSpec::Compute::Property::ProjectInfoCommonInstanceMetadata.new(@fetched['commonInstanceMetadata'], to_s)
    @enabled_features = @fetched['enabledFeatures']
    @default_service_account = @fetched['defaultServiceAccount']
    @xpn_project_status = @fetched['xpnProjectStatus']
    @default_network_tier = @fetched['defaultNetworkTier']
    @quotas = GoogleInSpec::Compute::Property::ProjectInfoQuotasArray.parse(@fetched['quotas'], to_s)
    @creation_timestamp = parse_time_string(@fetched['creationTimestamp'])
  end

  # Handles parsing RFC3339 time string
  def parse_time_string(time_string)
    time_string ? Time.parse(time_string) : nil
  end

  def exists?
    !@fetched.nil?
  end

  def to_s
    "ProjectInfo #{@params[:project]}"
  end

  def has_enabled_oslogin?
    @common_instance_metadata&.items&.each do |element|
      return true if element.key=='enable-oslogin' and element.value.casecmp('true').zero?
    end
    false
  end

  private

  def product_url(beta = false)
    if beta
      'https://www.googleapis.com/compute/beta/'
    else
      'https://www.googleapis.com/compute/v1/'
    end
  end

  def resource_base_url
    'projects/{{project}}'
  end
end
