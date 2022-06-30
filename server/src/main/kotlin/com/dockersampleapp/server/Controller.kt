package com.dockersampleapp.server

import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/greeting")
class Controller {
    @GetMapping
    fun getMessage(): List<String> {
        return listOf("hello")
    }
}