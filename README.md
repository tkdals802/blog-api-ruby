# README

- ruby-version = 3.4.1
- rails-version = 8.0.1
- postgres-version = 14.15
- 開発os = ubuntu
- 開発tool = ruby-mine, postman



### rails setup
本来は、.envファイルはpushしてはいけませんが、同じ環境のセッティングのために今回の場合だけpushしました。

ubuntuにpostgresqlをインストールした後、username、passwordを設定
postgresql
-username : postgres
-password : 123456

* `$ rails new blog-api --api --database=postgresql`
* `$ rails generate model User username:string password:string`
* `$ rails generate model Article user:references title:string content:string likes:integer`
* `$ rails db:setup`
* `$ rails db:migrate`

参考資料　https://medium.com/@oliver.seq/creating-a-rest-api-with-rails-2a07f548e5dc

### 任意で工夫したポイント

- login状態の維持、確認のためのjwt_token導入
- login、create userを除くapi呼び出しごとにjwt_token検証によるlogin状態確認
- article-tagのn:m関係具現のためのarticles_tags中間テーブル製作
- bcryptを使ったpassword hashing
- tagがdbになければtagを新しく作り、tag update時にarticle-tag関係を初期化して関係を新しく作成

### 困難を経験した部分

- ruby、railsのすべてを初めて使ってみること
- windowsで開発環境を作ろうとしましたが、setupの過程でいくつかの問題が生じてubuntuに移ることになりました
- postgresqlのsetting
- railsのルーティングに慣れていなかった問題

### DB Diagram 
<img src="https://github.com/user-attachments/assets/9fc1cc26-59bd-48d7-95f5-b5fa1c9e1104" width="50%" />

### Deploy 手順
1. aws ec2 実行 (ubuntu, freetier)
2. aws rds 実行 (postgresql, 14.15, freetier)
3. ec2 内部にrails、ruby、postgresqlを設置
   `$ rbenv install -l`
   
   `$ gem install bundler`

   `$ gem install rails`

   `$ sudo apt install ruby-railties`

   `$ sudo apt install -y postgresql-client`
   

3. ec2内部にENV設定
   `$ export SECRET_KEY_BASE=<プロジェクトの.envファイルのJWT_SECRETKEYの内容>`
   
   `$ export RAILS_MASTER_KEY=<プロジェクトの.envファイルのmaster.keyの内容>`

   `$ export BLOG_API_DATABASE_PASSWORD=<tkdals802> aws rdsのpassword`

4. config/database.yml fileの修整
   productionに username, host, passwordを設定
<img src="https://github.com/user-attachments/assets/c7b995c2-cfdf-4bd7-af27-9c0eb506a5f7" width="50%">

5. config/environments/production.rbにconfig.secret_key_base追加

   `config.secret_key_base = ENV["SECRET_KEY_BASE"]`   

6. docker
   local
   
    `$ docker build -t ruby_blog .`
   
    `$ docker tag ruby_blog chasangmin/ruby_blog:1.4`
   
    `$ docker push chasangmin/ruby_blog:1.4`
   
   ec2 console
   
    `$ docker pull chasangmin/ruby_blog:1.4`
   
    `$ sudo docker run -e RAILS_ENV=production -e SECRET_KEY_BASE=$SECRET_KEY_BASE -e RAILS_MASTER_KEY=$RAILS_MASTER_KEY -e BLOG_API_DATABASE_PASSWORD=$BLOG_API_DATABASE_PASSWORD -d -p 3000:3000 chasangmin/ruby_blog:1.4`
   
  8. api address = http://54.180.196.79:3000/api/

   参考　＝　https://medium.com/@waseem.ghafoor/deploy-rails-app-on-ec2-instance-using-docker-7dfeb58bb643

   9. tokenを送るとき'Filter chain halted as :authorized rendered or redirected'の問題が発生
      - ec2に JWT_SECRET_KEY ENVを追加
      `export JWT_SECRET_KEY=<jwt_secret_key>`
      - config/application.rbに ip port追加
      - <img src="https://github.com/user-attachments/assets/495cacb4-3650-4206-bae6-91c2631c0d0f">

      docker push
  
       

### project構造

* app/
  * controllers/
     * api/  -  api controllerのdirectory
  application_controller.rb  -  jwt tokenのcode
  * models/  -  db modelの 1:1 / 1:n / n:m 関係を正義
* config/
  * database.yml  -  postgres dbのusername, password, portを正義
  * routes.rb  -  api routeを正義
* db/
  *migrate/  -  db migrate file
  schema.rb  -  tableの形が正義
* .env  -  ENVの正義 ( example: jwt secret key )
* .gitignore  -  .env fileを追加
* Gemfile


## API文書
### localhost:3000/api ~
### /articles
-  GET /articles  -  すべてのarticles get
-  Get /articles/:id  -  idのarticleを get
-  POST /articles  -  create article
-  ```json
   {
    "article":{
        "title": "hello",
        "content": "hello world!!!",
        "user_id": 18,
        "category_name": "category_1",
        "tags": ["a","b","c"]
    }
   }
- PUT /articles/:id  -  update article
- ```json
  {
    "article":{
        "title": "put_title_ex",
        "content": "put_content_ex",
        "user_id": 18,
        "category_name": "category_1",
        "tags": ["a","b","c"]
    }
  }
- DELETE /articles/:id  -  delete article
- POST /articles/:article_id/tags  -  一つのarticleにtagを追加
- ```json
  {
    "tags": ["a","b","c","d"]
  }
- GET /articles/:article_id/tags  -  一つのarticleのすべてのtagをget
- GET /articles/search  -  keywordが含まれたtitleを検索
- ```json
  {
     "keyword": "a"
  }

### /usres
- GET /users  -  すべてのusersをget
- GET /users/:user_id  -  一つのuserをget
- POST /users  -  create user
- ```json
  {
    "user":{
        "username": "newuser",
        "password": "123456",
        "password_confirmation": "123456"
    }
  }
- POST /users/login  -  login
- ```json
  {
    "user":{
        "username":"newuser",
        "password":"123456"
    }
  }
- PUT /users/:user_id  -  update user info
- ```json
  {
    "user":{
        "username": "updateuser",
        "password": "123456",
        "password_confirmation": "123456"
    }
  }
- DELETE /users/:user_id  -  delete user

### /categories
- GET /categories  -  すべてのcategoriesをget

### /tags
- GET /tags  -  すべてのtagsをget
- GET /tags/:tag_id  -  一つのtagをget
- DELETE /tags/:tag_id  -  delete tag
- GET /tags/:tag_id/articles  -  tagに属しているすげてのarticleをget
- 



rails jwt 参考資料
https://dev.to/mohhossain/a-complete-guide-to-rails-authentication-using-jwt-403p

