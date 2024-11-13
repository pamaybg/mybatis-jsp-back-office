<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well">
    <div class="row qt_border" id="surveyAnalysis"></div>
</div>

<script type="text/javascript">
	
    var pageObjectSurveyAnalysis = {
        init: function () {
            this.getSurveyAnalysis();
        },
        getSurveyAnalysis: function () {
            $.ifvPostJSON('${pageContext.request.contextPath}/loyalty/survey/getSurveyAnalysis.do', {
                rid: pageObjectSurveyDetail.ridSurvey
            }, function (response) {
            	//console.log(response.rows);
                if( response.rows  != null && response.rows != '') {
                	$.each(response.rows, function (index, item) { 
                		if (item.fieldTypeCode == "RADIO")
                			createBarChart(item);
                		else if (item.fieldTypeCode == "CHECK_BOX")
                			createPieChart(item);
                	});
                } else {
	                $('#surveyAnalysis').text("<spring:message code='C00035' />");
				}
            });
        },
    };
    
    var setBarSeriesData = function( rowData ) {
    	var seriesList = new Array();
    	
    	$.each(rowData, function (index, item) { 
    		//console.log(item);
    		
    		var row = new Object();
    		var data = new Array();
    		
    		row.name = item.name;
    		data.push(item.data);
    		
    		row.data = data;
    		
    		seriesList.push(row);
    	});
    	
    	return seriesList;
    };
    
    var createBarChart = function(rowData) {
    	//console.log(rowData);
    	
    	//자식 노드 만들기
    	var length = $("#surveyAnalysis").children().length;
    	var divId = "chart_" + length;
    	var div = document.createElement('div');
    	div.setAttribute("id", divId);
    	div.setAttribute("style", "width:70vw; height:70vh;");
    	
    	//부모 노드에 추가 하기
    	document.getElementById('surveyAnalysis').appendChild(div);

	    var el = document.getElementById(divId);
	    
	    var data = {
	            categories: [''],
	            series: setBarSeriesData(rowData.survSubList),
	            /*
	             series: [
	               {
	                name: '구간번호 1 - 문항 번호 1- 보기 번호 1',
	                data: [1],
	              },
	              {
	                name: '구간번호 1 - 문항 번호 1- 보기 번호 2',
	                data: [2],
	              },
	              {
	                name: '구간번호 1 - 문항 번호 1- 보기 번호 3',
	                data: [3],
	              },
	              {
	                name: '구간번호 1 - 문항 번호 1- 보기 번호 4',
	                data: [4],
	              }, 
	            ], 
	            */
	          };    
	    
	    var options = {
	      chart: { title: rowData.sectionNo + '-' + rowData.itemNo + '. ' + rowData.itemTitle , width: 900, height: 400 }, //, width: 900, height: 400 width: 'auto', height: 'auto'
	      series: { dataLabels: { visible: true } },
	    };
	
	    toastui.Chart.barChart({ el, data, options });
    };
    
    var createPieChart = function(rowData) {
    	//자식 노드 만들기
    	var length = $("#surveyAnalysis").children().length;
    	var divId = "chart_" + length;
    	var div = document.createElement('div');
    	div.setAttribute("id", divId);
    	div.setAttribute("style", "width:70vw; height:70vh;");
    	
    	//부모 노드에 추가 하기
    	document.getElementById('surveyAnalysis').appendChild(div);
    	
        var el = document.getElementById(divId);
        
        var data = {
                categories: [''],
                series: rowData.survSubList,
                /*
                series: [
                  {
                    name: 'Chrome',
                    data: 1,
                  },
                  {
                    name: 'IE',
                    data: 20.47,
                  },
                  {
                    name: 'Firefox',
                    data: 17.71,
                  },
                  {
                    name: 'Safari',
                    data: 5.45,
                  },
                  {
                    name: 'Opera',
                    data: 3.1,
                  },
                  {
                    name: 'Etc',
                    data: 7.25,
                  }, 
                ],
                */
              };
          var options = {
            chart: { title: rowData.sectionNo + '-' + rowData.itemNo + '. ' + rowData.itemTitle, width: 600, height: 400 }, //, width: 600, height: 400 width: 'auto', height: 'auto'
            series: { dataLabels: { visible: true } }, //{ visible: true, anchor: 'outer' }
          };

          toastui.Chart.pieChart({ el, data, options });
	};    
    

    $(document).ready(function () {
    	pageObjectSurveyAnalysis.init();
    });

</script>