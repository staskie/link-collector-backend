class LinkForm
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def submit(params)
    assign_attributes(params)

    if link.save
      true
    else
      false
    end
  end

  def errors
    @link.errors
  end

  private

  def assign_attributes(params)
    link.user = params[:user] if params.has_key?(:user)
    link.url  = params[:url]  if params.has_key?(:url)
    link.name = params[:name] if params.has_key?(:name)

    if params[:category_name].present?
      link.category = Category.where(name: params[:category_name])
                              .first_or_create
    end
  end
end
