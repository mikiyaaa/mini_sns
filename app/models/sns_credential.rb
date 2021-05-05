class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true # 外部キーが空でも保存できる
end
