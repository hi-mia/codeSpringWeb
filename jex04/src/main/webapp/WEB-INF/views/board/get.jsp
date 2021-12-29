<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">Board Register</h1>
  </div>
  <!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading">Board Read Page</div>
      <!-- /.panel-heading -->
      <div class="panel-body">

          <div class="form-group">
          <label>Bno</label> <input class="form-control" name='bno'
            value='<c:out value="${board.bno }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Title</label> <input class="form-control" name='title'
            value='<c:out value="${board.title }"/>' readonly="readonly">
        </div>

        <div class="form-group">
          <label>Text area</label>
          <textarea class="form-control" rows="3" name='content'
            readonly="readonly"><c:out value="${board.content}" /></textarea>
        </div>

        <div class="form-group">
          <label>Writer</label> <input class="form-control" name='writer'
            value='<c:out value="${board.writer }"/>' readonly="readonly">
        </div>

<%-- 		<button data-oper='modify' class="btn btn-default">
        <a href="/board/modify?bno=<c:out value="${board.bno}"/>">Modify</a></button>
        <button data-oper='list' class="btn btn-info">
        <a href="/board/list">List</a></button> --%>


<button data-oper='modify' class="btn btn-default">Modify</button>
<button data-oper='list' class="btn btn-info">List</button>

<%-- <form id='operForm' action="/boad/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
</form> --%>


<form id='operForm' action="/board/modify" method="get">
  <input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
  <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
  <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>  
 
</form>

      </div>
      <!--  end panel-body -->

    </div>
    <!--  end panel-body -->
  </div>
  <!-- end panel -->
</div>
<!-- /.row -->


<div class='row'>

  <div class="col-lg-12">

    <!-- /.panel -->
    <div class="panel panel-default">
<!--       <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
      </div> -->
      
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> Reply
        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
      </div>      
      
      <!-- /.panel-heading -->
      <div class="panel-body">        
      
        <ul class="chat">
        </ul>
      </div>
	  <!-- /.panel .chat-panel 추가 -->
	  <div class="panel-footer">
	  </div>


		</div>
  </div>
  <!-- ./ end row -->
</div>

 <!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
		</div>
		<div class="modal-body">
			<div class="form-group">
				<label>Reply</label>
				<input class="form-control" name='reply' value='New Reply!!!!'>
			</div>
			<div class="form-group">
				<label>Replyer</label>
				<input class="form-control" name='replyer' value='replyer'>
			</div>
			<div class="form-group">
				<label>Reply Date</label>
				<input class="form-control" name='replyDate' value=''>
			</div>
		
		</div>
<div class="modal-footer">
        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
		</div>		</div>
		<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		
<script type="text/javascript" src="/resources/js/reply.js"></script>
<script>

$("#modalCloseBtn").on("click", function(){
	$('#myModal').modal("hide"); //닫기 
});

$(document).ready(function(){	

	//모달창 바깥 누르면 자동으로 닫힘
	window.onclick = function(e) {
		if(e.target == modal) {
			modal.style.visibility = "hidden";
			modal.style.opacity = 0;
			
		}
		
	}
	
	var bnoValue = '<c:out value = "${board.bno}"/>';
	var replyUL = $(".chat");
	
	showList(1);
	
	function showList(page) { //reply.js를 이용해서 댓글의 페이지 호출
		
		console.log("show list " + page);
		
	    replyService.getList({bno:bnoValue,page: page|| 1 }, 
	function(replyCnt, list) {
	    	console.log("replyCnt: " + replyCnt );
	    	console.log("list: " + list);
	    	console.log(list);
	    	
	    	//페이징
	    	if(page == -1) {
	    		pageNum = Math.ceil(replyCnt/10.0);
	    		showList(pageNum);
	    		return;
	    	}
	    	
	    	//댓글 호출
			var str = "";
			if(list == null || list.length == 0) {
				replyUL.html("");
				return;
			}
		     for (var i = 0, len = list.length || 0; i < len; i++) {
		         str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
		         str +="  <div><div class='header'><strong class='primary-font'>["
		      	   +list[i].rno+"] "+list[i].replyer+"</strong>"; 
		         str +="    <small class='pull-right text-muted'>"
		             +replyService.displayTime(list[i].replyDate)+"</small></div>";
		         str +="    <p>"+list[i].reply+"</p></div></li>";
		       }
		     replyUL.html(str);
		     
		     showReplyPage(replyCnt);
		}); //end function
	} //end showList
	
	//댓글 페이지 번호 출력
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt) {
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt/10.0);
		}
		
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul class='pagination pull-right'>";
		
		if(prev) {
			str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
		}
		
	      for(var i = startNum ; i <= endNum; i++){
	          
	          var active = pageNum == i? "active":"";
	          
	          str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	        }
	      
	      if(next) {
	    	  str+= "<li class='page-item'><a class='page-link' href='" + (endNum + 1)+"'>Next</a></li>"
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
		
	}
	
	//페이지 번호를 클릭했을 때 새로운 댓글을 가져오도록
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		console.log("targetPageNum: " + targetPageNum);
		pageNum = targetPageNum;
		
		showList(pageNum);
		
	});
	
	//modal창
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn"); //modal과 관련된 객체들은 바깥으로 빼둔다(자주 쓰니까)
	
	$("#addReplyBtn").on("click", function(e){
		
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show(); //등록버튼 show
		
		$(".modal").modal("show");
	});
	
	//등록버튼 이벤트 처리
	modalRegisterBtn.on("click", function(e){
		
		var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				bno: bnoValue
		};
		replyService.add(reply, function(result){
			
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			//showList(1); //댓글 추가후 다시 댓글 목록 갱신
			showList(-1); // 먼저 전체 댓글 숫자 파악
		});
	});
	
	//댓글 조회 클릭 이벤트 처리(이벤트 위임)
	$(".chat").on("click", "li", function(e){//이벤트 위임: 이미 존재하는 요소에 이벤트 걸어준 뒤 나중에 이벤트 대상을 변경
		var rno = $(this).data("rno");
		//console.log(rno);
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer);
			modalInputReplyDate. val(replyService.displayTime( reply.replyDate))
			.attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	});
	
	modalModBtn.on("click", function(e){
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
		
		replyService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
	});
	
	modalRemoveBtn.on("click", function (e){
		var rno = modal.data("rno");
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(pageNum);
		});
		
	});
	
});

</script>

<script>
/* 	$(document).ready(function(){
console.log(replyService);
}); */

//console.log("==============");
//console.log("JS TEST")

//for replyService add test
/*
	replyService.add(
	{reply: "JS Test", replyer:"tester", bno:bnoValue}
	,
	function(result) {
		alert("RESULT: " + result);
	}
);
*/

//댓글 가져오는지 테스트
/*
replyService.getList({bno:bnoValue, page:1}, function(list){
	for(var i = 0, len = list.length||0; i < len; i++){
		console.log(list[i]);
	}
});	
*/
//23번 댓글 삭제 테스트
/*
	replyService.remove(23, function(count) {
	console.log(count);
	
	if(count === "success") {
		alert("REMOVED");
	}
}, function(err) {
	alert('ERROR...');
});
*/

//22번 댓글 수정
/*
	replyService.update({
	rno : 22,
	bno : bnoValue,
	reply : "Modified Reply...."
	
}, function(result){
	alert("수정 완료....");
});
*/

/*
	replyService.get(10, function(data){
	console.log(data);
});
*/


</script>

<script type="text/javascript">
$(document).ready(function(){
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		operForm.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list")
		operForm.submit();
	});
});

</script>    

<%@include file="../includes/footer.jsp"%>
