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
-  ```json
   {
    "message": "get article successfully",
    "article": {
        "id": 21,
        "user_id": 15,
        "title": "title_ex",
        "content": "content_ex",
        "created_at": "2025-02-14T04:36:01.259Z",
        "updated_at": "2025-02-14T04:36:01.259Z",
        "category_id": 6
    },
    "category_name": "21",
    "tags": [
        {
            "id": 29,
            "name": "421",
            "created_at": "2025-02-14T04:36:01.271Z",
            "updated_at": "2025-02-14T04:36:01.271Z"
        }
    ]
   }
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


  
  /users
  /tags
  /categories



* ...
