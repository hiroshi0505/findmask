// ページが読み込まれた時にイベント実行
window.addEventListener("load", function(){
  // id=submitの要素を取得し変数に代入
  const submit = document.getElementById("submit");
  // id=submitがクリックされたらイベント実行
  submit.addEventListener("click", (e) => {
    // フォームに入力された値を取得できるFormDataオブジェクトを使用
    // id=formの要素を取得し、FormDataオブジェクトを生成し、変数に代入
    const formData = new FormData(document.getElementById("form"));
    // XMLHttpRequestオブジェクトを生成し、変数に代入
    const XHR = new XMLHttpRequest();

      const nickname = document.getElementById("tweet_nickname");
      const nicknameId = nickname.value;

      const nowTime = document.getElementById("now_time");
      const time = nowTime.value;
    
      const tweet = document.getElementById("tweet_id");
      const tweetId = tweet.value;

    // openメソッドを使用して、リクエストの内容を引数へ追記
    // HTTPメソッドはPOST、パスはcomment#create行きのURI Pattern、非同期通信はtrueと設定
    XHR.open("POST", `/tweets/${tweetId}/comments`, true);
    // 返却されるデータ形式はJSON
    XHR.responseType = "json";
    // formDataを送信
    XHR.send(formData);
    XHR.onload = () => {
      // 200以外のHTTPステータスが返却された場合はアラートを出すという処理
      if (XHR.status != 200){
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      // レスポンスとして返却されたコメントのレコードデータを取得し、変数に代入
      const item = XHR.response.comment;
      // HTMLを描画する場所を指定する際に使用する「描画する親要素」のid=listの要素を取得し変数に代入
      const list = document.getElementById("list");
      // id=textの要素を取得し変数に代入
      const formText = document.getElementById("text");
      // 「コメントとして描画する部分のHTML」を定義しています
      const HTML =`
                <div class="comment">
                  <div>${nicknameId}さん</div>
                      「${item.text}」${time}
                </div>
                `;
      // listという要素に対して、insertAdjacentHTMLでHTMLを追加します。
      // 第一引数にafterendを指定することで、要素listの直後に挿入できます。
      list.insertAdjacentHTML("afterend", HTML);
      // この処理が終了した時に、入力フォームの文字は入力されたままになってしまうため
      // 入力フォームに入力されたままの文字をリセットする.正確には空の文字列を上書きする仕組み
      formText.value = "";
    };
    // このままではコントローラーのcreateアクションと、JavaScriptの処理が重複しているので
    // e.preventDefault();でプログラム本来の処理(コメントコントローラーのcreateアクション)を停止させます
    e.preventDefault();
  });
});