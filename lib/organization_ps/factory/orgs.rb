module OrganizationPs
  module Factory
    class Orgs
      class << self
        def create_company(uuid, name)
          OrganizationPs.organization_class.company.enabled.create(
            uuid: uuid,
            abbrev_name: name,
            full_name: name,
            code: "company_#{uuid}"
          )
        end

        def create_org(typing, name, code)
          OrganizationPs.organization_class.send(typing).enabled.create(
            abbrev_name: name,
            full_name: name,
            code: code
          )
        end
      end
    end
  end
end
