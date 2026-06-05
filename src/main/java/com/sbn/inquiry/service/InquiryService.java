package com.sbn.inquiry.service;

public interface InquiryService {
    boolean sendInquiry(String senderName, String senderPhone, String senderEmail,
                        String subject, String content);
}