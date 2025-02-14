# README

- ruby-version = 3.4.1
- rails-version = 8.0.1
- postgres-version = 14.15
- 開発os = ubuntu
- 開発tool = ruby-mine

DB Diagram `\n`
<img src="https://github.com/user-attachments/assets/9fc1cc26-59bd-48d7-95f5-b5fa1c9e1104" width="50%" />




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



* ...
