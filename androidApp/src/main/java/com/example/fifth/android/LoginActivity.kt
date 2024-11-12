package com.example.fifth.android

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import com.example.fifth.LoginViewModel

class LoginActivity : ComponentActivity() {

    val loginViewModel: LoginViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            LoginScreen(
                viewModel = loginViewModel,
                onAction = { action -> handleAction(action) }
            )

        }
    }
    private fun handleAction(action: LoginViewModel.Action) {
        when (action) {
            LoginViewModel.Action.ShowNext -> {
                finish()
                val intent = Intent(this, HomeActivity::class.java)
                startActivity(intent)
            }
        }
    }
}

