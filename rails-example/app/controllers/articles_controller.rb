class ArticlesController < ApplicationController
  def new
    if /ZAP\/2.7/ =~ request.user_agent
      logger.info "not allowing scanner to post"
      render plain: "403 scanner not allowed to add data", status: 403
    else
      self.request.env.select {|k,v| k =~ /^HTTP_/}.each do |k,v|
        logger.info "header: #{k} = #{v}"
      end

      @article = Article.new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    self.request.env.select {|k,v| k =~ /^HTTP_/}.each do |k,v|
      logger.info "header: #{k} = #{v}"
    end

    redirect_to articles_path
  end

  def index
    self.request.env.select {|k,v| k =~ /^HTTP_/}.each do |k,v|
      logger.info "header: #{k} = #{v}"
    end

    @articles = Article.all
  end

  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    self.request.env.select {|k,v| k =~ /^HTTP_/}.each do |k,v|
      logger.info "header: #{k} = #{v}"
    end

    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)

    self.request.env.select {|k,v| k =~ /^HTTP_/}.each do |k,v|
      logger.info "header: #{k} = #{v}"
    end
   
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
 
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end

