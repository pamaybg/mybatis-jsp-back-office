package com.icignal.common.base.dto.response;

import java.util.ArrayList;
import java.util.List;

public class MultiUploadResDto extends StatusResDto{
	private List<UploadResDto> items;

	public List<UploadResDto> getItems() {
		if(this.items == null)
			this.items = new ArrayList<>();
		return items;
	}

	public void setItems(List<UploadResDto> items) {
		this.items = items;
	}
	
	
}
