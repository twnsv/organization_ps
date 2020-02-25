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

  require 'organization_ps/factory/nodes'
  require 'organization_ps/factory/orgs'
  require 'organization_ps/trunk/growth'
  require 'organization_ps/finder/orgs'
  require 'organization_ps/finder/users'
  require 'organization_ps/finder/authorities'
  require 'organization_ps/service/org_nodes'
end
