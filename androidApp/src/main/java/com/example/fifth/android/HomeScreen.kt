package com.example.fifth.android

import android.content.Context
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.example.fifth.HomeViewModel
import com.example.new.MR
import dev.icerock.moko.resources.desc.desc


@Composable
fun HomeScreen(
    viewModel: HomeViewModel,
    onAction: (HomeViewModel.Action) -> Unit
) {
    val context: Context = LocalContext.current

    val login: String by viewModel.login.collectAsState()
    val isLoading: Boolean by viewModel.isLoading.collectAsState()
    val isLoginButtonEnabled: Boolean by viewModel.isButtonEnabled.collectAsState()

    LaunchedEffect(viewModel.actions) {
        viewModel.actions.collect { action ->
            onAction(action)
        }
    }

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White)
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            TextField(
                modifier = Modifier.fillMaxWidth(),
                value = login,
                enabled = !isLoading,
                label = { Text(text = MR.strings.login.desc().toString(context)) },
                onValueChange = { viewModel.login.value = it }
            )

            Spacer(modifier = Modifier.height(8.dp))

            Button(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(48.dp),
                enabled = isLoginButtonEnabled,
                onClick = viewModel::goBack
            ) {
                if (isLoading) CircularProgressIndicator(
                    modifier = Modifier.size(
                        24.dp
                    )
                )
                else Text(text = MR.strings.go_back.desc().toString(context))
            }
        }
    }
}

