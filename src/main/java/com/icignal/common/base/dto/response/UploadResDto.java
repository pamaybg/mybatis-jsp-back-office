package com.icignal.common.base.dto.response;

import java.util.HashMap;

public class UploadResDto extends StatusResDto{

	private HashMap<String, String> images;

	public HashMap<String, String> getImages() {
		if(this.images == null)
			this.images = new HashMap<>();
		return images;
	}

	public void setImages(HashMap<String, String> images) {
		this.images = images;
	}
}
