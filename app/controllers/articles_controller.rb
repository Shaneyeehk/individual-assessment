class ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :edit, :update, :destroy]

	# def new
		
	# end

	def index
		@article = Article.search(params[:search_terms])
	end

	def user_articles
		@article = current_user.articles
	end

	def show
		# @article = Article.find_by(id: params[:id])
	end

	def edit
		
	end

	def update
		if @article.update(article_params)
			redirect_to @article 
		else
			render 'edit'
		end
	end

	def create
		@article = Article.new(article_params)
		@article = current_user.articles.new(article_params)

		if @article.save
			redirect_to articles_path, notice: 'Successfuly created'
		else
			render 'new', notice: 'Could not create, please try again.'
		end
	end

	def destroy
		@article.destroy
		redirect_to user_articles_path
	end

	private

		def article_params
			params.require(:article).permit(:title, :description, :author)
		end

		def find_article
			@article = Article.find(params[:id])
		end

end
