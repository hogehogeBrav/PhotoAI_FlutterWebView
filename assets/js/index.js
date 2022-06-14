$(function(){

  // $("#myImage").on("change", function (e) {
  //   var reader = new FileReader();
  //   reader.onload = function (e) {
  //     $("#preview").attr("src", e.target.result);
  //   };
  //   reader.readAsDataURL(e.target.files[0]);
  // });
  
  //API Server URL
  const url = "http://127.0.0.1:8081/predict";

  $('h2').append("画像を選択すると判別します");

  $("#myImage").on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $("#preview").attr("src", e.target.result);
    };
    reader.readAsDataURL(e.target.files[0]);

    $('h2').text("判別中...");
    $('h2').css('color' , 'black');
    var fd = new FormData();  //画像データ送信に必要なFromDataインスタンス作成
    fd.append('image', $(this).prop('files')[0]); //取得した画像データを追加

    $.ajax({
      headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'),
      },
      url: url,
      type: 'POST',
      data: fd,
      processData: false,
      contentType: false, 
      dataType: 'text'
    })
      .done(function (data) {
        result = JSON.parse(data);
        console.log(result[0])
        $('h2').text(Math.round(result[0].results * 100) + '％の確率で' + result[0].labels + 'やんけ！');
        $('h2').css('color' , 'red');
      })
      .fail(function (data) {
        $('h2').text('通信に失敗しました');
      })
  });
});