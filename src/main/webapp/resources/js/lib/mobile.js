$.extend({
	
	ifvGetParams : function(){
	    var vars = [], hash;
	    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++){
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];
	    }
	    return vars;
	},
	 
	ifvGetParam : function(name){
		return $.ifvGetParams()[name];
	},

	webViewClose : function(){
		var andSchemas = $.ifvGetParam("andSchemas");
		var iosSchemas = $.ifvGetParam("iosSchemas");
		var iOS = /(iPad|iPhone|iPod)/g.test( navigator.userAgent );
		location.href = ( iOS == true ?  iosSchemas : andSchemas )  + '://closeWebView';
	},
	
	
	ifvAjax : function( obj ){
		
		$.ajax({
			url : obj.url,
			type : "POST",
			dataType : 'json',
			data : $.toJSON( obj.data ),
			contentType : "application/json; charset=utf-8",
			success : obj.success,
			async : true,
			complete : function(xhr, status) {
				
			}
		});
	},
	
	
	ikReplaceHtmlTag : function(value) {
		return value.replace(/&/g, '&amp;').replace(/>/g, '&gt;')
				.replace(/</g, '&lt;').replace(/\n/g, ' <br>');
	},
	ikReplaceHttpToAnchor : function(value) {
		var result = $.ikReplaceHttpTag(value, -1);
		result = result.replace(/replaceA/gi, 'http:');
		result = $.ikReplaceHttpsTag(result, -1);
		result = result.replace(/replaceA/gi, 'https:');
		return result;
	},
	ikReplaceHttpTag : function(value, searchIndex) {
		if (value.toLowerCase().indexOf('http:') > searchIndex) {
			var startIndex = value.toLowerCase().indexOf('http:');
			var endIndex = value.length;
			for (var i = startIndex; i < value.length; i++) {
				if (value.charAt(i) == ' ') {
					endIndex = i;
					break;
				}
			}

			var httpString = value.substring(startIndex, endIndex);

			var replaceString = httpString.replace(/http:/gi,
					'replaceA');

			value = value.replace(httpString, '<a href="'
					+ replaceString + '" target="_blank">'
					+ replaceString + '</a>');

			var lastIndex = value.lastIndexOf('</a>') + 3;

			var result = $.ikReplaceHttpTag(value, lastIndex);
			if (result == value)
				return value;
			else
				value = result;
		}

		return value;
	},
	ikReplaceHttpsTag : function(value, searchIndex) {
		if (value.toLowerCase().indexOf('https:') > searchIndex) {
			var startIndex = value.toLowerCase().indexOf('https:');
			var endIndex = value.length;
			for (var i = startIndex; i < value.length; i++) {
				if (value.charAt(i) == ' ') {
					endIndex = i;
					break;
				}
			}

			var httpString = value.substring(startIndex, endIndex);

			var replaceString = httpString.replace(/https:/gi,
					'replaceA');

			value = value.replace(httpString, '<a href="'
					+ replaceString + '" target="_blank">'
					+ replaceString + '</a>');

			var lastIndex = value.lastIndexOf('</a>') + 3;

			var result = $.ikReplaceHttpsTag(value, lastIndex);
			if (result == value)
				return value;
			else
				value = result;
		}

		return value;
	}
	
	
});


if(!Array.sortOn){
    Array.prototype.sortOn = function($key){
        /*this.sort(
            function(a, b){
                return (a[$key] > b[$key]) - (a[$key] < b[$key]);
            }
        );*/
    	var dup = this.slice();
		if(!arguments.length) return dup.sort();
		var args = Array.prototype.slice.call(arguments);
		return dup.sort(function(a,b){
			var props = args.slice();
			var prop = props.shift();
			while(a[prop] == b[prop] && props.length) prop = props.shift();
			return a[prop] == b[prop] ? 0 : a[prop] > b[prop] ? 1 : -1;
		});
    };
};