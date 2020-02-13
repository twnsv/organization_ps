module OrganizationPs
  module Factory
    class Nodes
      class << self
        def create_root(org)
         OrganizationPs.tree_node_class.company.enabled.create(nodeable: org, code: org.uuid, name: org.abbrev_name)
        end

        def create_child(parent_node, org)
          parent_node.children.send(org.typing).enabled.create(nodeable: org, code: org.code, name: org.abbrev_name)
        end

        def create_user(org_node, user, typing)
          org_node.children.send(typing).enabled.create(nodeable: user, code: user.uuid, name: user.name)
        end
      end
    end
  end
end
