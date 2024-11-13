/* ----------------------------------------------------------------------------------------- */
(function(){

    var fnIfvExcelDownload = function( gridId) {

        var grid = null;
        var gridId = "gridId" + gridId;
        if (gridId instanceof jQuery) {
            grid = gridId;
        } else {
            grid = $("#" + gridId);
        }

        var gridObj = grid.getGridParam();
        var colNames = gridObj.colNames; // Grid Names
        var colModels = gridObj.colModel; // Grid Models
        var actionUrl = gridObj.url;
        var record = gridObj.records;
        var orderby = gridObj.sortname;
        var postData = gridObj.postData.item;



        $.ifvSyncPostJSON( actionUrl,
   			 {item: postData ,
   		      strOrderby : orderby ,
   		      skipCount : 0 ,
   			  pageSize : record},
   			 function(result){
   		    	  $.ifvSyncPostJSON( '/loyalty/common/excelExport.do' ,
   		 				 { fileName : 'excelTest' ,
   		 		  		   header: colModels  ,
   		 		  		   headerName : colNames ,
   		 			       data : result.rows },
   		 				 function(result){
   		 			    	  location.href = result.message ;
   		 			     }

   		 			     );

   			 },function(result){
   				 alert("데이터가 존재하지 않습니다.");
   			 }

        );
    };

    window.fnIfvExcelDownload = fnIfvExcelDownload;
})();
