module OrganizationPs
  module Finder
    class Orgs
      attr_reader :company_node

      def initialize(uuid)
        @company_node =  OrganizationPs.tree_node_class.roots.includes(:nodeable, :children).find_by_code(uuid)
      end

      def departments()
        company_node.children.department.enabled.includes(:nodeable)
      end

      class << self
        def add_typing_org_node(typing)
          define_method "#{typing}_org_node" do |*arg|

            org_node = company_node.children&.includes(:nodeable).send(typing)&.find_by_code(arg[0].to_s)

            {
              organization: org_node&.nodeable,
              tree_node: {
                node: org_node,
                parent: company_node
              }
            }
          end
        end
      end
    end
  end
end
