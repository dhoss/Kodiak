class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      success_msg = 'Category was successfully created'
      if @category.save
        format.html { redirect_to @category, notice: success_msg }
        # the @category.to_h.merge(...) stuff should be moved to a module
        format.json { 
          render json: @category.to_h.merge(notice: success_msg), status: :created, location: @category }
        format.js { render json: @category.to_h.merge(notice: success_msg), content_type: 'text/json' }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params[:category]
    end
end
