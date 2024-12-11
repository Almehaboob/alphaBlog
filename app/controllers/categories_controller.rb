class CategoriesController < ApplicationController


  before_action :require_admin, except: [:index, :show]


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully"
      redirect_to @category
    else
      flash.now[:alert] = "Failed to create category. Please fix the errors below."
      render :new
    end
  end


  def edit
    @category=Category.find(params[:id])

  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully"
      redirect_to category_path(@category)  
    else
      render 'edit'
    end
  end
  











  def index
    @categories = Category.page(params[:page]).per(3)
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin)
      flash[:alert] = "only admin can perform that action"
      redirect_to categories_path
    end
  end

end
