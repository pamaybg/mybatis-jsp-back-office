package com.icignal.common.apiservice.service;

	public class SSLTrustManager implements javax.net.ssl.TrustManager,
	javax.net.ssl.X509TrustManager {
	@Override
	public java.security.cert.X509Certificate[] getAcceptedIssuers() {
	return new java.security.cert.X509Certificate[0];
	}
	
	public boolean isServerTrusted(java.security.cert.X509Certificate[] certs) {
	//System.out.println("X509Certificate : " + certs);
	return true;
	}
	
	public boolean isClientTrusted(java.security.cert.X509Certificate[] certs) {
//	System.out.println("X509Certificate : " + certs);
	return true;
	}
	
	@Override
	public void checkServerTrusted(java.security.cert.X509Certificate[] certs,
	String authType) throws java.security.cert.CertificateException {
//	System.out.println("AUTH TYPE : " + certs[0]);
	return;
	}
	
	@Override
	public void checkClientTrusted(java.security.cert.X509Certificate[] certs,
	String authType) throws java.security.cert.CertificateException {
//	System.out.println("AUTH TYPE : " + authType);
	return;
	}

}