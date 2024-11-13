function checkYearMonthDupl(names){
	var rtnVal = names.slice() 
	.sort(function(a,b){
		return b - a;
	})
	.reduce(function(a,b){
		if (a.slice(-1)[0] !== b) a.push(b); 
		return a;
	},[]); 

	return rtnVal;
}

function checkDupl(names){
	var uniq = names.reduce(function(a,b){
		if (a.indexOf(b) < 0 ) a.push(b);
		return a;
	  },[]);
	
	return uniq;
}

function makeObjectArray(arr, keyNm){
	var rtnArr = [];
	
	for(var i=0; i<arr.length; i++){
		var obj = new Object();
		
		obj.key = keyNm;
		obj.value = arr[i];
		rtnArr.push(obj);
	}
	
	return rtnArr;
}

function yearMonthSetting(year, month){
	var rtnArr = [];
	var pYear = Number(year);
	var pMonth = Number(month);
	
	if(pMonth <= "7"){
		rtnArr.push( String(pYear) + "0" + pMonth );
		rtnArr.push( String(pYear) + "0" + (pMonth+1) );
		rtnArr.push( String(pYear) + "0" + (pMonth+2) );
	}else if(pMonth == "8"){
		rtnArr.push( String(pYear) + "0" + pMonth );
		rtnArr.push( String(pYear) + "0" + (pMonth+1) );
		rtnArr.push( String(pYear) + (pMonth+2) );
	}else if(pMonth == "9"){
		rtnArr.push( String(pYear) + "0" + pMonth );
		rtnArr.push( String(pYear) + (pMonth+1) );
		rtnArr.push( String(pYear) + (pMonth+2) );
	}else if(pMonth == "10"){
		rtnArr.push( String(pYear) + pMonth );
		rtnArr.push( String(pYear) + (pMonth+1) );
		rtnArr.push( String(pYear) + (pMonth+2) );
	}else if(pMonth == "11"){
		rtnArr.push( String(pYear) + pMonth );
		rtnArr.push( String(pYear) + (pMonth+1) );
		rtnArr.push( String(pYear+1) + "01" );
	}else if(pMonth == "12" ){
		rtnArr.push( String(pYear) + pMonth );
		rtnArr.push( String(pYear+1) + "01" );
		rtnArr.push( String(pYear+1) + "02" );
	}
	
	return rtnArr;
}

function termSetting(id, pTermType){
	var rtnArr = [];

	if($("#"+id+" option").length > 0){
		var termLen = $("#"+id+" option").length;
		
		if(pTermType == "cd"){
			for(var i=0; i<termLen; i++){
				rtnArr.push($("#"+id+" option")[i].value);
			}
		}else if(pTermType == "nm"){
			for(var i=0; i<termLen; i++){
				rtnArr.push($("#"+id+" option")[i].text);
			}
		}
		
	}
	
	return rtnArr;
}

function dateSetting(yearId, tempYearId, monthId, tempMonthId){
	var tDate = new Date();
	
	//연도 세팅
	var tFullYear = tDate.getFullYear();
	var yearArr = [];
	for(var i=0; i<4; i++){
		yearArr.push(tFullYear - i);
	}
	
	var resYear = $("#"+tempYearId).tmpl(makeObjectArray(yearArr, "year"));
	$("#"+yearId).append(resYear);
	
	//월 세팅
	var monthArr = [];
	for(var i=1; i<10; i++){
		monthArr.push("0"+i);
	}
	for(var i=10; i<13; i++){
		monthArr.push(i);
	}
	
	var resMonth = $("#"+tempMonthId).tmpl(makeObjectArray(monthArr, "month"));
	$("#"+monthId).append(resMonth);
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}