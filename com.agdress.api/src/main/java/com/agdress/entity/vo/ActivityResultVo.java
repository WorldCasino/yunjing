package com.agdress.entity.vo;

/**
 * Created by Administrator on 2017/8/28.
 * Description: *_*
 */
public class ActivityResultVo {
    private long activityId;
    private String summary;
    private String imageUrl;
    private String linkUrl;
    private String linkTitle;
    private String linkRemarks;

    public long getActivityId() {
        return activityId;
    }

    public void setActivityId(long activityId) {
        this.activityId = activityId;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getLinkTitle() {
        return linkTitle;
    }

    public void setLinkTitle(String linkTitle) {
        this.linkTitle = linkTitle;
    }

    public String getLinkRemarks() {
        return linkRemarks;
    }

    public void setLinkRemarks(String linkRemarks) {
        this.linkRemarks = linkRemarks;
    }
}
