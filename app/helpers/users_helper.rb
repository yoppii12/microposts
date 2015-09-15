#[ヘルパー]モデルの情報を受け取って表示用の出力を行うメソッドを入れるモジュール
module UsersHelper
    def gravatar_for(user, options = {size: 80})
        #メールアドレスからGravatarの画像用のURLを生成してgravatar_urlに代入
        gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
        size=options[:size]
        gravatar_url="https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end

