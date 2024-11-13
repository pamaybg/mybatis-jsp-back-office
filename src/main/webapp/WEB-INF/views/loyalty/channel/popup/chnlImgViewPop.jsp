<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>

img { max-width: 100%; height: auto; }


</style>

<div class="form-horizontal underline top_well" id="chnlImgNewDetail">
	<div class="row qt_border">
 		<div class="col-xs-12">
	 	<div class="content" id="imageContent"></div>
	</div> 
	</div>
</div>

<script type="text/javascript">
var imageUrl =null;
function getChnlLoyImgDesc() {
		$.ifvSyncPostJSON('<ifvm:action name="getLoyImgDesc"/>', {
			rid : chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0].rid
		}, function(result) {
			
			$("#descChnlImg").val(result.rows[0].comments);
			imageUrl= result.rows[0].imgPath;
			$("#imgPathId").val(imageUrl);
			$("#seqNo").val(result.rows[0].seqNo);
					
		});
	}
	
function saveImgDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="saveImgDetail"/>', {
		rid : chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0].rid
		, seqNo : $("#seqNo").val()
		,chnlRid : channelDetail_rid
	}, function(result) {
		if(result.message=="dupSeqNo"){
			alert("이미 존재하는 순번입니다.");
		}else{
			alert(result.message);
		    addChnlImgPopupClose();
		 chnlLoyImgListGrid._doAjax();
		}		
	});
}


$(document).ready(function() {
	getChnlLoyImgDesc();
	  var img = document.createElement('img');
 	 img.src = imageUrl; // 이미지 경로 설정
	 img.id="imgViewDiv";
	 document.getElementById('imageContent').appendChild(img);
	
	 $("#btnCancel").click(function() {
		 openChnlImgPopClose();
		});

	});
</script>