package com.sbn.inquiry.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.sbn.inquiry.service.InquiryService;

@Service
public class InquiryServiceImpl implements InquiryService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${admin.email}")
    private String adminEmail;

    @Override
    public boolean sendInquiry(String senderName, String senderPhone, String senderEmail,
                                String subject, String content) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(adminEmail);
            message.setSubject("[SBN 문의] " + subject);
            message.setText(
                "─────────────────────────────\n" +
                " 문의자 정보\n" +
                "─────────────────────────────\n" +
                "이름    : " + senderName  + "\n" +
                "연락처  : " + senderPhone + "\n" +
                "이메일  : " + senderEmail + "\n" +
                "─────────────────────────────\n" +
                " 문의 내용\n" +
                "─────────────────────────────\n" +
                content + "\n"
            );
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}