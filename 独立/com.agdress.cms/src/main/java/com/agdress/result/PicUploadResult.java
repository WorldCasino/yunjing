package com.agdress.result;

public class PicUploadResult {

	private int error;

	/**
	 * 图片保存路径
	 */
	private String url;

	/**
	 * 模糊处理后的图片保存路径
	 */
	private String blurFileUrl;

	private String width;
	
	private String height;

	public PicUploadResult() {

	}

	public int getError() {
		return error;
	}

	public void setError(int error) {
		this.error = error;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getBlurFileUrl() {
		return blurFileUrl;
	}

	public void setBlurFileUrl(String blurFileUrl) {
		this.blurFileUrl = blurFileUrl;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

}
