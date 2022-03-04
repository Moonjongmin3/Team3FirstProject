/**
 *  검색 JS
 */
 
 function searchMain(){
	let keyword=$('#keyword').val()==undefined?"":$('#keyword').val().trim()
	console.log(keyword)
	var f = $('#search_form')
	if(keyword==""){
		alert("검색어를 입력하시오!!")
		return;
	}else{ 
		f.submit()
	}
} 

function btnplus(){
	let count=$("#input_cnt").val()
	count = (Number(count)+1)
	$("#input_cnt").val(count)
}
function btndown(){
	let count=$("#input_cnt").val()
	count = (Number(count)-1)
	if(count===0){
		alert("1개 이상 구입할 수 있습니다.")
		$("#input_cnt").val(1)
	}else{
		$("#input_cnt").val(count)
	}
}
function search(){
	let taftCheck=new Array()
	let subcateCheck=new Array()
	var tf = $('#search_form')
	$("input:checkbox[name='taftck']:checked").each(function(){
			taftCheck.push(this.value)
			$('#keyword').before("<input type='hidden' name='taftck' value='"+this.value+"'>")
		})
		if(taftCheck.length < 1 ){
            alert('검색조건을 최소한 1개 이상 항목을 선택하셔야 합니다');
            return false;
        }
		$("input:checkbox[name='search_left_categoty']:checked").each(function(){
			subcateCheck.push($(this).attr("sub-id"))
			$('#keyword').before("<input type='hidden' name='sub_categoty' value='"+this.value+"'>")
		})
		tf.submit()
}
function mainBtn(maincate){
	let sel =$('#search_main_cate_sel>option')
	for(let i=0;i<sel.length;i++){
		if(sel[i].value==maincate){
			sel[i].selected=true;
		}
	}
	search()
}

function exceptSel(obj){
	let exsel = $(obj).val()
	$('#keyword').before("<input type='hidden' name='except' value='"+exsel+"'>")
	search()
}
function rowSize(obj){
	let rowSize=$(obj).val()
	$('#keyword').before("<input type='hidden' name='rowsize' value='"+rowSize+"'>")
	search()
}
function pageNum(page){
	let pagenum = page;
	console.log("pagenum은 "+pagenum);
	$('#keyword').before("<input type='hidden' name='page' value='"+page+"'>")
	search()
}

var i=0;
function checkAll(){
if(i==0){
		$('input[name=bookChk]').prop("checked",true)
		i=1;
		$('.bWrap').text("전체해제")
	}else{
		$('input[name=bookChk]').prop("checked",false)
		$('.bWrap').text("전체선택")
		i=0;
	}
}
function subCateDel(){
	$('input[name=search_left_categoty]').prop("checked",false)
	search()
}
$(function(){
	$('input[name=bookChk]').click(function(){
		let total = $('input[name=bookChk]').length;
		let checked=$('input[name=bookChk]:checked').length;
		
		if(total!=checked){
			$('.bWrap').text("전체선택")
			i=0;
		}
	})
	
	
})		
		


 