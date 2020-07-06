class Note < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            on: :create,
            length: { maximum: 30 }

  validates :title,
            presence: true,
            on: :update,
            length: { maximum: 30 }

  validates :body,
            on: :create,
            length: { maximum: 1000 }

  validates :body,
            on: :update,
            length: { maximum: 1000 }

  def validate_and_update(params)
    if params[:title].empty?
      params[:title] = params[:body][0..29]
    end

    return self.update(params)
  end

  def validate_and_save
    return self.save if valid_title?

    set_body_as_title if has_body?
    return self.save
  end

  def valid_title?
    title.size > 0 && title.size < 30
  end

  def has_body?
    body.size > 0
  end

  def set_body_as_title
    self.title = body[0..29]
  end
end