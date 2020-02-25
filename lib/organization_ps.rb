module OrganizationPs
  require "organization_ps/engine"

  mattr_accessor :organization_class
  mattr_accessor :tree_node_class
  mattr_accessor :user_class

  def self.organization_class
    @@organization_class.constantize
  end

  def self.tree_node_class
    @@tree_node_class.constantize
  end

  def self.user_class
    @@user_class.constantize
  end

  require 'organization/factory/nodes'
  require 'organization/factory/orgs'
  require 'organization/trunk/growth'
  require 'organization/finder/orgs'
  require 'organization/finder/users'
  require 'organization/finder/authorities'
  require 'organization/service/org_nodes'
end
