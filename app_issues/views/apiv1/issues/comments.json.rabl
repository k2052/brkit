object @comments

child @comment do  
  attributes :created_at
  attribute :desc_raw => :description       
  glue :user do
    attribute :name => :user
  end
end