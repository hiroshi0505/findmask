// インプットされた時にイベント発火
window.addEventListener("input", function(){
  // idの要素を取得し変数に代入
  const submit = document.getElementById("submit");
  const text   = document.getElementById("text");
  const btn    = document.getElementById("btn");
  // textの内容を値に変換し、変数に代入
  const textValue = text.value;
    // もしtextの文字数が0より大きければ
    if (textValue.length > 0) {
      // display:none;だったsubmitを出現させ、btnを非表示にさせる
      submit.setAttribute("style", "display:block;");
      btn   .setAttribute("style", "display:none;");
      // もしtextの文字数が0なら
    } else {
      // submitを非表示にし、btnを出現させる
      submit.setAttribute("style", "display:none;");
      btn   .setAttribute("style", "display:block;");
    };
});