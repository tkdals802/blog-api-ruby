# README

- ruby-version = 3.4.1
- rails-version = 8.0.1
- postgres-version = 14.15
- 개발 os = ubuntu
- 개발환경 = ruby-mine

### API
/api
-  GET /articles  -  get all articles
-  Get /articles/:id  -  get one article
-  POST /articles
-  ```json
   body example
   {
    "article":{
        "title": "hello",
        "content": "hello world!!!",
        "user_id": 18,
        "category_name": "category_1",
        "tags": ["a","b","c"]
    }
   }
- PUT /articles/:id
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
- DELETE /articles/:id
- POST /articles/:article_id/tags
- ```json
  {
    "tags": ["a","b","c","d"]
  }
- GET /articles/:article_id/tags

  
  /users
  /tags
  /categories



* ...
