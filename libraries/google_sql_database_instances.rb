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
class SQLDatabaseInstances < GcpResourceBase
  name 'google_sql_database_instances'
  desc 'DatabaseInstance plural resource'
  supports platform: 'gcp'

  attr_reader :table

  filter_table_config = FilterTable.create

  filter_table_config.add(:backend_types, field: :backend_type)
  filter_table_config.add(:connection_names, field: :connection_name)
  filter_table_config.add(:instance_versions, field: :instance_version)
  filter_table_config.add(:failover_replicas, field: :failover_replica)
  filter_table_config.add(:instance_types, field: :instance_type)
  filter_table_config.add(:ip_addresses, field: :ip_addresses)
  filter_table_config.add(:ipv6_addresses, field: :ipv6_address)
  filter_table_config.add(:master_instance_names, field: :master_instance_name)
  filter_table_config.add(:max_disk_sizes, field: :max_disk_size)
  filter_table_config.add(:instance_names, field: :instance_name)
  filter_table_config.add(:instance_regions, field: :instance_region)
  filter_table_config.add(:replica_configurations, field: :replica_configuration)
  filter_table_config.add(:settings, field: :settings)
  filter_table_config.add(:instance_zones, field: :instance_zone)
  filter_table_config.add(:instance_states, field: :instance_state)

  filter_table_config.connect(self, :table)

  def initialize(params = {})
    super(params.merge({ use_http_transport: true }))
    @params = params
    @table = fetch_wrapped_resource('items')
  end

  def fetch_wrapped_resource(wrap_path)
    # fetch_resource returns an array of responses (to handle pagination)
    result = @connection.fetch_all(product_url, resource_base_url, @params, 'Get')
    return if result.nil?

    # Conversion of string -> object hash to symbol -> object hash that InSpec needs
    converted = []
    result.each do |response|
      next if response.nil? || !response.key?(wrap_path)
      response[wrap_path].each do |hash|
        hash_with_symbols = {}
        hash.each_key do |key|
          name, value = transform(key, hash)
          hash_with_symbols[name] = value
        end
        converted.push(hash_with_symbols)
      end
    end

    converted
  end

  def transform(key, value)
    return transformers[key].call(value) if transformers.key?(key)

    [key.to_sym, value]
  end

  def transformers
    {
      'backendType' => ->(obj) { return :backend_type, obj['backendType'] },
      'connectionName' => ->(obj) { return :connection_name, obj['connectionName'] },
      'databaseVersion' => ->(obj) { return :instance_version, obj['databaseVersion'] },
      'failoverReplica' => ->(obj) { return :failover_replica, GoogleInSpec::SQL::Property::DatabaseInstanceFailoverReplica.new(obj['failoverReplica'], to_s) },
      'instanceType' => ->(obj) { return :instance_type, obj['instanceType'] },
      'ipAddresses' => ->(obj) { return :ip_addresses, GoogleInSpec::SQL::Property::DatabaseInstanceIpAddressesArray.parse(obj['ipAddresses'], to_s) },
      'ipv6Address' => ->(obj) { return :ipv6_address, obj['ipv6Address'] },
      'masterInstanceName' => ->(obj) { return :master_instance_name, obj['masterInstanceName'] },
      'maxDiskSize' => ->(obj) { return :max_disk_size, obj['maxDiskSize'] },
      'name' => ->(obj) { return :instance_name, obj['name'] },
      'region' => ->(obj) { return :instance_region, obj['region'] },
      'replicaConfiguration' => ->(obj) { return :replica_configuration, GoogleInSpec::SQL::Property::DatabaseInstanceReplicaConfiguration.new(obj['replicaConfiguration'], to_s) },
      'settings' => ->(obj) { return :settings, GoogleInSpec::SQL::Property::DatabaseInstanceSettings.new(obj['settings'], to_s) },
      'gceZone' => ->(obj) { return :instance_zone, obj['gceZone'] },
      'state' => ->(obj) { return :instance_state, obj['state'] },
    }
  end

  private

  def product_url(_ = nil)
    'https://www.googleapis.com/sql/v1beta4/'
  end

  def resource_base_url
    'projects/{{project}}/instances'
  end
end
