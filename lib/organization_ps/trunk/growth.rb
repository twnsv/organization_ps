module OrganizationPs
  module Trunk
    class Growth
      class << self
        def create_org_root(uuid, name)
          org = OrganizationPs::Factory::Orgs.create_company(uuid, name)
          root = OrganizationPs::Factory::Nodes.create_root(org)

          {
            organization: org,
            tree_node: root
          }
        end

        def add_org_node(parent_node, typing, name, code)
          org = OrganizationPs::Factory::Orgs.create_org(typing, name, code)
          node = OrganizationPs::Factory::Nodes.create_child(parent_node, org)

          manager_org = OrganizationPs::Factory::Orgs.create_org('manager', '主管', "#{org.code}_manager")
          manager_node = OrganizationPs::Factory::Nodes.create_child(node, manager_org)

          member_org = OrganizationPs::Factory::Orgs.create_org('member', '員工', "#{org.code}_member")
          member_node = OrganizationPs::Factory::Nodes.create_child(node, member_org)

          {
            organization: org,
            tree_node: {
              node: node,
              children: {
                manager: manager_node,
                member:  member_node
              }
            }
          }
        end

        def add_org_user_node(org_node, user, typing)
          role_node = org_node.children.send(typing).first
          user_node = OrganizationPs::Factory::Nodes.create_user(role_node, user, typing)

          {
            user: user,
            tree_node: {
              node: user_node,
              parent: {
                organization: org_node,
                role_node: role_node
              }
            }
          }
        end
      end
    end
  end
end
