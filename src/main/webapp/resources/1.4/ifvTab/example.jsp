<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link type="text/css" rel="stylesheet" href="tab.css">

<div id="testTab"></div>
<script type="text/javascript" src="tab.js"></script>
<script type="text/javascript">
var testTab = $('#testTab').ifvTab({
	item: [
		{label: '탭1', href: '/test/tab1'},
		{label: '탭2', href: '/test/tab2'},
		{label: '탭3', href: '/test/tab3'},
		{label: '탭4', href: '/test/tab4'},
		{label: '탭5', href: '/test/tab5'},
		{label: '탭6', href: '/test/tab6'},
		{label: '탭7', href: '/test/tab7'},
		{label: '탭8', href: '/test/tab8'},
		{label: '탭9', href: '/test/tab9'},
		{label: '탭10', href: '/test/tab10'},
		{label: '탭11', href: '/test/tab11'},
		{label: '탭12', href: '/test/tab12'},
		{label: '탭13', href: '/test/tab13'},
		{label: '탭14', href: '/test/tab14'},
		{label: '탭15', href: '/test/tab15'}
	]
});
</script>