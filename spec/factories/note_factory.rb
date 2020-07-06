FactoryBot.define do
  factory :note do
    title { 'This is the title' }
    body { 'Some text goes here'}
    user
  end
end