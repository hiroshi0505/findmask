// newとeditのページのみ下記のファンクションを実行
if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {

  // HTMLが最初に読み込まれたときに動作する関数を定義
  document.addEventListener('DOMContentLoaded', function(){

    // 画像を表示するためのHTMLの要素(id)を、JavaScript側で取得し、変数imageListとして宣言
    const imageList = document.getElementById('image-list');
    // id=tweet_image要素の値に変更があった場合、関数が発火
    document.getElementById('tweet_image').addEventListener('change', function(e){

      // 画像が表示されている場合のみ、すでに存在している画像を削除する
      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }
      // 画像の情報は、e.target.files[0]として、発火したEventハッシュに格納されているオブジェクトから取得
      // 取得した画像の情報は、変数fileとして宣言
      const file = e.target.files[0];
      // 変数fileを引数として渡すことで、画像のURLを生成し、変数blobとして宣言
      const blob = window.URL.createObjectURL(file);
      // 画像を表示するためのdiv要素を生成
      const imageElement = document.createElement('div');
      // 画像を表示するimg要素を生成
      const blobImage = document.createElement('img');
      // 画像情報を生成したimg要素のsrc属性に、画像情報（変数blobに格納されている値）を指定
      blobImage.setAttribute('src', blob);
      
      // appendChildは、指定した親要素の中に要素を追加するメソッドです
      // <div><img></div>
      imageElement.appendChild(blobImage);
      // <image-list><div><img></div></image-list>
      imageList.appendChild(imageElement);
    });
  });
}