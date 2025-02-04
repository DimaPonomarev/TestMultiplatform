package com.example.fifth.android

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import com.example.fifth.HomeViewModel
import com.example.fifth.LoginViewModel

class HomeActivity: ComponentActivity() {

    val homeViewModel: HomeViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            HomeScreen(
                viewModel = homeViewModel,
                onAction = { action -> handleAction(action)
                }
            )

        }
    }

    private fun handleAction(action: HomeViewModel.Action) {
        when (action) {
            HomeViewModel.Action.GoBack -> {
                finish()
                val intent = Intent(this, LoginActivity::class.java)
                startActivity(intent)
            }
        }
    }
}