class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index,:show]
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Your category was successfuly created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Your category was succesfully updated"
      redirect_to categories_path
    else
      render 'edit'
    end    
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
      if !logged_in? || (!logged_in? && !current_user.admin?)
        flash[:danger] = "only admin can do it"
        redirect_to categories_path
      end
    end

end
