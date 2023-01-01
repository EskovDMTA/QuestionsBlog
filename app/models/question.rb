class Question < ApplicationRecord
    include Commentable
    include Authorship

    has_many :answers, dependent: :destroy
    belongs_to :user
    has_many :question_tags, dependent: :destroy
    has_many :tags, through: :question_tags
    
    scope :all_by_tags, ->(tag_ids) do
        questions = includes(:user, :question_tags, :tags)
        questions = questions.joins(:tags).where(tags: tag_ids) if tag_ids
        questions.order(created_at: :desc)
    end


end
