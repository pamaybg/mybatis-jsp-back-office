<%@page import="java.util.UUID"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function setChart(){
	$("#container").show();
	$("#container").ifvsfChart({
		series: 
			[
		{
                  points: [{ x: "USA", y: 50 }, { x: "China", y: 40 }, 
					 { x: "Japan", y: 70 }, { x: "Australia", y: 60 },
                           { x: "France", y: 50 }, { x: "Germany", y: 40 },
					 { x: "Italy", y: 40 }, { x: "Sweden", y: 30 }],
                  name: 'Gold',fill:"rgba(135,206,235,1)"
              },                                
		{
                  points: [{ x: "USA", y: 70 }, { x: "China", y: 60 }, 
					 { x: "Japan", y: 60 }, { x: "Australia", y: 56 },
                           { x: "France", y: 45 }, { x: "Germany", y: 30 }, 
					 { x: "Italy", y: 35 }, { x: "Sweden", y: 25 }],
                  name: 'Silver',fill:"rgba(255,255,0,0.7)"
              },
              {
                  points: [{ x: "USA", y: 45 }, { x: "China", y: 55 },
					 { x: "Japan", y: 50 }, { x: "Australia", y: 40 },
                           { x: "France", y: 35 }, { x: "Germany", y: 22 }, 
					 { x: "Italy", y: 37 }, { x: "Sweden", y: 27 }],
                  name: 'Bronze',fill:"rgba(255,204,153,1)"
              }
          ]
	});
}

$(document).ready(function() {
	setChart();	
});
</script>


<div class="dashboard_box">
	<div class="header_chart">
		<p class="tit_chart">거주지별 고객 비율</p>
		<span class="icon_area">
			<a href="javascript:;"><i class="fa fa-cog"></i></a><!-- 설정 -->
			<a href="javascript:;"><i class="fa fa-pencil-square-o"></i></a><!-- 수정 -->
			<a href="javascript:;"><img src="<ifv:image name='ico_close' />" alt="" /></a><!-- 삭제 -->
		</span>
	</div>
	<div class="chart_area" id="container"></div>
</div>

<div class="dashboard_box">
	<div class="header_chart">
		<p class="tit_chart">거주지별 고객 비율</p>
		<span class="icon_area">
			<a href="javascript:;"><i class="fa fa-cog"></i></a>
			<a href="javascript:;"><i class="fa fa-pencil-square-o"></i></a>
			<a href="javascript:;"><img src="<ifv:image name='ico_close' />" alt="" /></a>
		</span>
	</div>
	<div class="chart_area"></div>
</div>

<div class="dashboard_box">
	<div class="header_chart">
		<p class="tit_chart">거주지별 고객 비율</p>
		<span class="icon_area">
			<a href="javascript:;"><i class="fa fa-cog"></i></a>
			<a href="javascript:;"><i class="fa fa-pencil-square-o"></i></a>
			<a href="javascript:;"><img src="<ifv:image name='ico_close' />" alt="" /></a>
		</span>
	</div>
	<div class="chart_area"></div>
</div>

<div class="dashboard_box">
	<div class="header_chart">
		<p class="tit_chart">거주지별 고객 비율</p>
		<span class="icon_area">
			<a href="javascript:;"><i class="fa fa-cog"></i></a>
			<a href="javascript:;"><i class="fa fa-pencil-square-o"></i></a>
			<a href="javascript:;"><img src="<ifv:image name='ico_close' />" alt="" /></a>
		</span>
	</div>
	<div class="chart_area"></div>
</div>