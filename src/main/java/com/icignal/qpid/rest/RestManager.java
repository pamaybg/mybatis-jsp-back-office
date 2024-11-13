package com.icignal.qpid.rest;

import java.util.List;

import org.springframework.web.client.RestTemplate;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;

/**
 * Qpid Rest API 요청 클래스
 *
 * @author jskim
 *
 */
public class RestManager {
	public static final String PRODUCTION_HOST = "https://www.qpid.co.kr";

	public static final String DEVELOPMENT_HOST = "http://14.63.173.15";

	public static final String SEND_PATH = "/pushSendingAPI/send";

	public enum Send_TYPE {
		Personal, Mass
	}

	public enum Push_TYPE {
		Notification, Direct_URL, HTML
	}

	public enum OS_TYPE {
		iOS, And
	}

	private String hostUri = "";
	private String sendUri = "";

	private boolean heavyDebugMode;
	private Notification noti;

	public RestManager(){
		this.noti = new Notification();
	}

	public void initializeConnection(String applicationId, String reqApplicationToken, String reqApplicationId,
			String customHost) {
		this.noti.setApplicationId(applicationId);
		this.noti.setReqApplicationToken(reqApplicationToken);
		this.noti.setReqApplicationId(reqApplicationId);

		this.hostUri = customHost;
		this.sendUri = this.hostUri + SEND_PATH;
	}

	public void initializeConnection(String applicationId, String reqApplicationToken, String reqApplicationId,
			boolean production) {
		this.initializeConnection(applicationId, reqApplicationToken, reqApplicationId,
				production ? PRODUCTION_HOST : DEVELOPMENT_HOST);
	}

	public StatusResDto sendNotifications(Payload payload, List<Device> devices) {
		this.noti.setPayload(payload);
		for (Device device : devices)
			this.noti.getDevices().add(device);

		String str = StringUtil.getObjectToJSON(this.noti);

		if (isHeavyDebugMode())
			LogUtil.debug(str);

		RestTemplate restTemplate = new RestTemplate();
		StatusResDto result = restTemplate.postForObject(this.sendUri, this.noti, StatusResDto.class);

		LogUtil.debug(result.toString());

		return result;
	}

	public boolean isHeavyDebugMode() {
		return heavyDebugMode;
	}

	public void setHeavyDebugMode(boolean heavyDebugMode) {
		this.heavyDebugMode = heavyDebugMode;
	}
	
}
