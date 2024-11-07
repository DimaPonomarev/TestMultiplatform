package com.example.fifth

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform