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
function newBooksearch(){
	var tf = $('#search_form')
	$('#keyword').before("<input type='hidden' name='rowsize' value='10'>")
	$('#keyword').before("<input type='hidden' name='sort' value='day'>")
	tf.submit()
}
function hotBooksearch(){
	var tf = $('#search_form')
	$('#keyword').before("<input type='hidden' name='rowsize' value='10'>")
	$('#keyword').before("<input type='hidden' name='sort' value='sellsort'>")
	tf.submit()
}
function sub_search(subid){
	var tf = $('#search_form')
	$('#keyword').before("<input type='hidden' name='sub_categoty' value='"+subid+"'>")
	$('#keyword').before("<input type='hidden' name='rowsize' value='10'>")
	tf.submit()
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
		return;
	}else{
		$("#input_cnt").val(count)
	}
}
function search(){
	let taftCheck=new Array()
	var tf = $('#search_form')
	$("input:checkbox[name='taftck']:checked").each(function(){
			taftCheck.push(this.value)
			let htmlstr="";
			htmlstr+= "<input type='hidden' name='taftck_s' value='"+this.value+"'>"
			
			let list=$('#search_opt_list')
			list.after(htmlstr);
		})
		if(taftCheck.length < 1 ){
            alert('검색조건을 최소한 1개 이상 항목을 선택하셔야 합니다');
            return false;
        }
	$("input:checkbox[name='search_left_categoty']:checked").each(function(){;
		let substr="";
			substr+= "<input type='hidden' name='sub_categoty' value='"+this.value+"'>"
			
			let list=$('#search_opt_list')
			list.after(substr);
		})
	let exsel = $('#except').val()
	$('#keyword').before("<input type='hidden' name='except' value='"+exsel+"'>")
	
	let rowSize=$('#rowSize').val()
	$('#keyword').before("<input type='hidden' name='rowsize' value='"+rowSize+"'>")
	
	let rekeyword=$('input[name=inResearch]').val()
		$('#keyword').before("<input type='hidden' name='research' value='"+rekeyword+"'>")
		
	if($('#except_search').is(":checked")==true){
		$('#keyword').before("<input type='hidden' name='except_rekeyword' value='Y'>")
	}else{
		$('#keyword').before("<input type='hidden' name='except_rekeyword' value='N'>")
	}	
	
	let sort = $('a[pick=check]').attr('sorted')
	if(sort==null){
		let xsort=$('a.currnt_sort').attr('sorted')
		$('#keyword').before("<input type='hidden' name='sort' value='"+xsort+"'>")
	}else{
		$('#keyword').before("<input type='hidden' name='sort' value='"+sort+"'>")
	}
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
function sortBtn(sort){ 
	console.log("sort="+sort)
	$('a[sorted='+sort+']').attr('pick','check')
	search()
}



 