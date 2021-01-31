<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<!DOCTYPE html>
<html>
<head>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.13.0/dist/sweetalert2.all.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<meta charset="UTF-8">
<title>영양소 확인</title>
</head>
<body>
<h2>데이터 검색</h2>
<section class="bg-warning">
<div class="container ">
	<div class="row">
	    <div class="col-md-12">
	        <div class="card bg-warning">
	            <div class="card-body">
	                <div class="row align-items-center justify-content-center">
            	        <div class="col-md-2">
                           <div class="form-group">
							<input class="form-control" id="name" name="fegie_name" placeholder="이름">
                           </div>
                        </div>
                		<div class="col-md-2">
                           <div class="form-group">
							<input class="form-control" id="amount" name="amount" value=1 readonly>
                           </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                              <select id="amount_name" class="form-control">
                                <option selected>type</option>
                                <c:forEach var="row" items="${row}">
                                <option><c:out value="${row.amount_name}"></c:out></option>
                                </c:forEach>
                              </select>                             
                            </div>
                        </div>
                        <div class="col-md-2">
            	           <button type="button" class="btn btn-primary btn-block" id="weight">Search</button>
            	        </div>
                	</div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</section>
<br>

<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">이름</th>
      <th scope="col">개수</th>
      <th scope="col">단위</th>
      <th scope="col">무게(g)</th>
    </tr>
  </thead>
    <tbody id="emptyTr">
 </tbody>
</table>

<br>
<hr>
<h2>데이터 추가</h2>
<section class="bg-warning">
<div class="container ">
	<div class="row">
	    <div class="col-md-12">
	        <div class="card bg-warning">
	            <div class="card-body">
	                <div class="row align-items-center justify-content-center">
            	        <div class="col-md-2">
                           <div class="form-group">
							<input class="form-control" id="name2" name="fegie_name" placeholder="이름">
                           </div>
                        </div>
                		<div class="col-md-2">
                           <div class="form-group">
							<input class="form-control" id="amount2" name="amount" value=1 readonly>
                           </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                             <input class="form-control" id="amount_name2" name="amount_name" placeholder="단위">                            
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                             <input class="form-control" id="weight2" name="weight" placeholder="무게(g)">                            
                            </div>
                        </div>
                        <div class="col-md-2">
            	           <button type="button" class="btn btn-primary btn-block" id="add">Add</button>
            	        </div>
                	</div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</section> 
<br>

<table class="table">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">이름</th>
      <th scope="col">개수</th>
      <th scope="col">단위</th>
      <th scope="col">무게(g)</th>
      <th scope="col">삭제</th>
    </tr>
  </thead>
    <tbody id="allList">
    <c:forEach var="list" items="${list}">
     <tr>
     	<td>#</td>
     	<td><c:out value="${list.fegie_name}"></c:out></td>
     	<td><c:out value="${list.amount}"></c:out></td>
     	<td><c:out value="${list.amount_name}"></c:out></td>
     	<td><c:out value="${list.weight}"></c:out></td>
     	<td><button id="delete" value='<c:out value="${list.bno}"></c:out>'>삭제</button></td>
     </tr>
    </c:forEach>
 </tbody>
</table>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	let emptyTr = $('#emptyTr');
	let allList = $('#allList');
	

	  $('#weight').click(function() {			   
		  
		  var fegie_name = $("#name").val();
		  console.log(fegie_name);
		  var amount = $("#amount").val();
		  console.log(amount);
		  var amount_name = $("#amount_name").val();
		  console.log(amount_name);
		  let text = '';
		  if(!$("#name").val()) {
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: '이름을 적어주세요.',      				  
			});
		 }
		  else if($("#amount_name").val() == 'type'){
			  emptyTr.empty();
			  console.log(fegie_name);
			  $.ajax({				
          	    url :'result1?fegie_name=' + fegie_name,
          	  	type : 'post',
           		dataType : 'JSON',
           		async:false,
           		success : function(data){
          		console.log(data);
        		let result = '';
        		//교환반품이 되었는지에 따라 버튼 색깔과 disabled를 적용합니다. (재원/21.01.13)
        		$.each(data,function(key,value){	      		            			
        			text+= '<tr>'
        			text += '<td>'+'#'+'</td>'
        			text += '<td>'+value.fegie_name+'</td>'
        			text += '<td>'+value.amount+'</td>'
        			text += '<td>'+value.amount_name+'</td>'
        			text += '<td>'+value.weight+'</td>'
        			text += '</tr>'
        		});
        		emptyTr.append(text);
        		console.log(text);

           },
           error : function(){	
              console.log("통신실패");
              console.log(fegie_name);
           }
			  
		  });
	  } else {
		  
		  emptyTr.empty();
		  $.ajax({
      	    url :'result2?fegie_name=' + fegie_name + '&' + 'amount=' + amount + '&' + 'amount_name=' + amount_name,
      	  	type : 'post',
       		dataType : 'JSON',
       		async:false,
       		success : function(data){
      		console.log(data);
    		let result = '';
    		//교환반품이 되었는지에 따라 버튼 색깔과 disabled를 적용합니다. (재원/21.01.13)
    		$.each(data,function(key,value){	      		            			
    			text+= '<tr>'
    			text += '<td>'+'#'+'</td>'
    			text += '<td>'+value.fegie_name+'</td>'
    			text += '<td>'+value.amount+'</td>'
    			text += '<td>'+value.amount_name+'</td>'
    			text += '<td>'+value.weight+'</td>'
    			text += '</tr>'
    		});
    		emptyTr.append(text);
    		console.log(text);

       },
       error : function(){	
          console.log("통신실패");
       }
		  
	  });
		  
	  }
		  
	  });

	  $("#add").click(function() {
		  
		  var fegie_name = $("#name2").val();
		 // console.log(fegie_name2);
		  var amount = $("#amount2").val();
		 // console.log(amount2);
		  var amount_name = $("#amount_name2").val();
		  var weight = $("#weight2").val();
		  console.log(weight);
		  var regExp = /^[+-]?\d*(\.?\d*)$/g;
		 // console.log(amount_name2);
		  let text = '';
		  if(!$("#name2").val()) {
			Swal.fire({
			  icon: 'error',
			  title: 'Oops...',
			  text: '이름을 적어주세요.',      				  
			});
		 }
		  else if(!$("#amount_name2").val()){
				Swal.fire({
					  icon: 'error',
					  title: 'Oops...',
					  text: '단위를 적어주세요.',      				  
					});
	  	}  else if(!$("#weight2").val() || regExp.test(weight) == false){
			Swal.fire({
				  icon: 'error',
				  title: 'Oops...',
				  text: '무게를 적어주세요. 무게 작성시 g는 빼고 숫자만 적습니다.',      				  
			});
		} else {
		  
		  allList.empty();
		  $.ajax({
      	    url :'addData?fegie_name=' + fegie_name + '&' + 'amount=' + amount + '&' + 'amount_name=' + amount_name + '&' + 'weight=' + weight,
      	  	type : 'post',
       		dataType : 'JSON',
       		async:false,
       		success : function(data){
      		
    		$.each(data,function(key,value){
    			console.log(value.weight);
    			text+= '<tr>'
    			text += '<td>'+'#'+'</td>'
    			text += '<td>'+value.fegie_name+'</td>'
    			text += '<td>'+value.amount+'</td>'
    			text += '<td>'+value.amount_name+'</td>'
    			text += '<td>'+value.weight+'</td>'
    			text += '<td>'+'<button id=delete value=' + value.bno + '>' + '삭제' + '</button>'+'</td>'
    			text += '</tr>'
    		});
    		allList.append(text);
    		//console.log(text);
    		$("#name2").val("");
    		$("#amount_name2").val("");
    		$("#weight2").val("");

       },
       error : function(){	
          console.log("통신실패");
       }
		  
	  });
		  
	  }
		  
		  
	  });
	  
	  
	  $('#allList').on('click', '#delete', function() {
		  var bno = $(this).val();
		 	console.log(bno);
		  allList.empty();
		  let text = '';
		  $.ajax({
      	    url :'deleteData?bno=' + bno,
      	  	type : 'post',
       		dataType : 'JSON',
       		async:false,
       		success : function(data){
      		//console.log(data);
    		$.each(data,function(key,value){	      		            			
    			text+= '<tr>'
    			text += '<td>'+'#'+'</td>'
    			text += '<td>'+value.fegie_name+'</td>'
    			text += '<td>'+value.amount+'</td>'
    			text += '<td>'+value.amount_name+'</td>'
    			text += '<td>'+value.weight+'</td>'
    			text += '<td>'+'<button id=delete value=' + value.bno + '>' + '삭제' + '</button>'+'</td>'
    			text += '</tr>'
    		});
    		allList.append(text);

       },
       error : function(){	
          console.log("통신실패");
       }
		  
	  });
		  
		  
	  })
		       		 
});
</script>

</body>
</html>