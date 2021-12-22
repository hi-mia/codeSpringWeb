<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Upload with Ajax</h1>

<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>

<style>
.uploadResult {
	width:100%;
	background-color: gray;
}

.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img{
	width: 100px;
}

.uploadResult ul li span{
	color:white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background:rgba(255,255,255,0.5);
}

.bigPicture{
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width:600px;
}
</style>

<div class='bigPictureWrapper'>
	<div class='bigPicture'>
	</div>
</div>

<div class="uploadResult">
	<ul>
	
	</ul>
</div>

<button id='uploadBtn'>Upload</button>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<script>
//섬네일 파일을 클릭할 때 div(이미지 보여줌) 처리
function showImage(fileCallPath){
	//alert(fileCallPath);
	$(".bigPictureWrapper").css("display", "flex").show();
	  $(".bigPicture")
	  .html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
	  .animate({width:'100%', height: '100%'}, 1000);

	}

//커진 섬네일 없애기(크롬)
$(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'100%', height: '100%'}, 1000);
	setTimeout(() => {
		$(this).hide();
	}, 1000);
});
//IE용
/*
 $(".bigPictureWrapper").on("click", function(e){
	$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	setTimeout(function(){
		$('.bigPictureWrapper').hide();
	}, 1000);
});
 */

//파일 삭제(x표시)에 대한 이벤트 처리(화면단)
	$(".uploadResult").on("click","span", function(e){
		   
		  var targetFile = $(this).data("file");
		  var type = $(this).data("type");
		  var targetLi = $(this).closest("li");
		  console.log(targetFile);
		  
		  $.ajax({
		    url: '/deleteFile',
		    data: {fileName: targetFile, type:type},
		    dataType:'text',
		    type: 'POST',
		      success: function(result){
		         alert(result);
		         targetLi.remove();
		       }
		  }); //$.ajax
		  
	});

 
$(document).ready(function(){
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
	
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var cloneObj = $(".uploadDiv").clone(); //<input type='file'> 초기화(readonly라 별도의 방법으로 초기화)
	
	$("#uploadBtn").on("click", function(e){
		
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
		//add File Data to formData
		for(var i=0; i < files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		
	//첨부파일 데이터는 formData에 추가한 뒤 Ajax를 통해서 formData 자체를 전송함
	$.ajax({
		url: '/uploadAjaxAction', 
		processData: false, //반드시 false
		contentType: false, //반드시 false
		data: formData,
			type: 'POST',
			dataType:'json',
			success: function(result) {
				//alert("Uploaded");
				console.log(result);
				
				showUploadedFile(result);
				
				$(".uploadDiv").html(cloneObj.html());
			}
		}); //$.ajax
		
	});
});

	//파일 이름 출력
	var uploadResult = $(".uploadResult ul");
	
		function showUploadedFile(uploadResultArr) {
			var str = "";
			$(uploadResultArr).each(function(i, obj) {
				
				if(!obj.image){
					//str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
					   var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
				       
					   var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					   
				       //str += "<li><a href='/download?fileName="+fileCallPath+"'><img src='/resources/img/attach.png'>"+obj.fileName+"</a></li>"
				       //화면에서 삭제기능
				    	str += "<li><div><a href='/download?fileName="+fileCallPath+"'>"+
							"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
							"<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
							"<div></li>"
				}else {
					//str += "<li>" + obj.fileName + "</li>";
					//URI 호출에 적합한 문자열로 인코딩 처리(공백, 한글 제거)
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					
					//str += "<li><img src='/display?fileName="+fileCallPath+"'><li>";
					//화면에서 삭제기능
					str += "<li><a href=\"javascript:showImage(\'"+originPath+"\')\">"+
						"<img src='display?fileName="+fileCallPath+"'></a>"+
						"<span data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
						"<li>";
				}

			});
			uploadResult.append(str);
		}
		
		
</script>

</body>
</html>