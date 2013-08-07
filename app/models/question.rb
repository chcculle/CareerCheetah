class Question < ActiveRecord::Base
  include RankedModel

  belongs_to :section
  has_many :response_options

  ranks :row_order, :with_same => :section_id

  def program
    phase.program
  end

  def phase
    section.phase
  end

  def next_question
    section.questions.rank(:row_order).where(["row_order > ?", row_order]).first
  end

  def previous_question
    section.questions.rank(:row_order).where(["row_order < ?", row_order]).last
  end

end
