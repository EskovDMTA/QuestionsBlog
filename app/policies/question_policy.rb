class QuestionPolicy < ApplicationPolicy
    def index?
        true
    end

    def show?
        true
    end

    def create?
        user.present?
    end

    def update?
        user.admin_role? || user.moderator_role? || user.author?(record)
    end
end