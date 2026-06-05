package com.sbn.inquiry.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.sbn.inquiry.service.InquiryService;
import com.sbn.member.dto.MemberDto;
import jakarta.servlet.http.HttpSession;

@Controller
public class InquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping("/Inquiry/Form")
    public String inquiryForm() {
        return "support/inquiryform";
    }

    @PostMapping("/Inquiry/Send")
    public String sendInquiry(
            @RequestParam String subject,
            @RequestParam String content,
            HttpSession session) {

        MemberDto login = (MemberDto) session.getAttribute("login");

        boolean result = inquiryService.sendInquiry(
            login.getMember_name(),
            login.getPhone_num(),
            login.getEmail(),
            subject,
            content
        );

        return result
            ? "redirect:/Inquiry/Form?success=true"
            : "redirect:/Inquiry/Form?error=true";
    }
}