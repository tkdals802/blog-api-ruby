class CreateCategoriesTagTable < ActiveRecord::Migration[8.0]
  def change
    # Categories 테이블 생성
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    # Tags 테이블 생성
    create_table :tags do |t|
      t.string :name, null: false
      t.timestamps
    end

    # ArticlesTags (중간 테이블) 생성
    create_table :articles_tags, id: false do |t|
      t.belongs_to :article, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true
    end

    # 인덱스를 추가하여 name 컬럼을 유니크하게 설정
    add_index :categories, :name, unique: true
    add_index :tags, :name, unique: true
  end
end
