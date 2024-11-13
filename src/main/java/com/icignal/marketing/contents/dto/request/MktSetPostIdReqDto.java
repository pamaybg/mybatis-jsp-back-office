package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

public class MktSetPostIdReqDto extends MKTGridPagingReqDto{
	
	private String id;
	private String postId;
	private String memId;

	
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
