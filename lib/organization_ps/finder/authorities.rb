module OrganizationPs
  module Finder
    class Authorities
      attr_reader :company_node

      def initialize(uuid)
        @company_node =  OrganizationPs.tree_node_class.roots.includes(:nodeable, :children).find_by_code(uuid)
      end

      def authority_index
        nodes = all_user_nodes

        {}.tap do |index_hash|
          nodes.find_each do |node|
            department_node = node&.parent&.parent

            if index_hash[node.nodeable_id]
              node_data = index_hash[node.nodeable_id]
              node_data[:departmen] << department_node&.name
              role_option = node.manager? ? :manager : :member
              node_data[role_option] << department_node.code
            else
              index_hash[node.nodeable_id] = {
                departmen: [node.parent&.parent&.name],
                manager:  node.manager? ? [node.parent.parent.code] : [],
                member: node.member? ? [node.parent.parent.code] : [],
              }
            end

            if department_node&.code == 'headquarter'
              index_hash[node.nodeable_id][:in_headquarter] = true
            end
          end
        end.symbolize_keys
      end

      def manager_users
        all_manager_users
      end

      def manager_users_in_department(department_code)
        all_manager_users[department_code.to_sym]
      end

      private

      def all_manager_users
        manager_nodes = company_node.find_all_by_generation(2).manager.includes(:nodeable, :parent, :children)

        {}.tap do |nodes_hash|
          manager_nodes.find_each do |node|
            nodes_hash[node.parent.code] = {
              name: node.parent.name,
              user_ids: node.children.pluck(:nodeable_id)
            }
          end
        end.symbolize_keys
      end

      def all_user_nodes
        company_node.find_all_by_generation(3).includes(:nodeable, parent: :parent)
      end
    end
  end
end
