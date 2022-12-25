module Admin
    module UsersHelper
        def users_roles
            User.roles.keys.each do |role|
                [role.titleize, role]
            end
        end
    end

end