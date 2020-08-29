// ページが読み込まれた時にイベント発火
window.addEventListener("load", function(){
  // id="btn"の要素を変数btnへ代入
  const btn = document.getElementById("btn");
  // btn要素がクリックされた時に、アラートが出るというイベントが発生
  btn.addEventListener("click", function(){    
    alert("入力して下さい");
  });
});