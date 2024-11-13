package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprProdListsResDto extends StatusResDto {

	
	private List<KprProdListResDto> items;

	public List<KprProdListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprProdListResDto> items) {
		this.items = items;
	}

}
