# README

- ruby-version = 3.4.1
- rails-version = 8.0.1
- postgres-version = 14.15
- 개발 os = ubuntu
- 개발환경 = ruby-mine

### API
/api
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

- GET /categories  -  すべてのcategoriesをget


  
  /users
  /tags
  /categories



* ...
