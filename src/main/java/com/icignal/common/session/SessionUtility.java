package com.icignal.common.session;

import java.util.List;

import javax.servlet.http.HttpSession;

/*-
 * ==================================================
 *  Class Name  : BMWSessionUtility.java
 *  Create Date : 2018. 1. 31.
 *  Create User : 이기오
 * ==================================================
 *  History
 * --------------------------------------------------
 *  Modify Date  | Modify User  | Description
 * -------------- -------------- --------------------
 *  2018. 1. 31.   이기오         최초작성
 * ==================================================
 * */
public class SessionUtility {
	public static final  void addSession(HttpSession session) {
		MKTSessionManager.getInstance().addSession(session);
	}

	public static final  void removeSession(HttpSession session) {
		MKTSessionManager.getInstance().removeSession(session);
	}

	public static final  HttpSession getSession(String id, boolean isSessionId) {
		return MKTSessionManager.getInstance().getSession(id, isSessionId);
	}

	public static final  List<HttpSession> getSessions(List<String> memIds) {
		return MKTSessionManager.getInstance().getSessions(memIds);
	}

	public static final  void printSessionPool() {
		MKTSessionManager.getInstance().printSessionPool();
	}
}
