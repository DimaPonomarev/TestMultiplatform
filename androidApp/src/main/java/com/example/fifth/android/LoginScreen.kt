package com.example.fifth.android

import android.content.Context
import android.widget.Toast
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material.AlertDialog
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.material.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.fifth.LoginViewModel
import dev.icerock.moko.mvvm.flow.compose.observeAsActions
import kotlinx.coroutines.launch

@Composable
fun LoginScreen(
    viewModel: LoginViewModel,
    onAction: (LoginViewModel.Action) -> Unit
) {
    val context: Context = LocalContext.current
    val coroutineScope = rememberCoroutineScope()

    val login: String by viewModel.login.collectAsState()
    val password: String by viewModel.password.collectAsState()
    val isLoading: Boolean by viewModel.isLoading.collectAsState()
    val isLoginButtonEnabled: Boolean by viewModel.isButtonEnabled.collectAsState()
    val isAlertShown by viewModel.isAlertShown.collectAsState()

    LaunchedEffect(viewModel.actions) {
        viewModel.actions.collect { action ->
            onAction(action)
        }
    }
    Box(
        modifier = Modifier
            .background(Color.White)
            .fillMaxSize()
    ) {
        Column(
            modifier = Modifier
                .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally

        ) {
            TextField(
                modifier = Modifier
                    .padding(bottom = 8.dp)
                    .fillMaxWidth(),
                value = login,
                enabled = !isLoading,
                label = { Text(text = "Login") },
                onValueChange = { viewModel.login.value = it }
            )
            TextField(
                modifier = Modifier
                    .padding(bottom = 8.dp)
                    .fillMaxWidth(),
                value = password,
                enabled = !isLoading,
                label = { Text(text = "Password") },
                visualTransformation = PasswordVisualTransformation(),
                onValueChange = { viewModel.password.value = it }
            )
            Button(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(48.dp),
                enabled = isLoginButtonEnabled,
                onClick = viewModel::onLoginPressed
            ) {
                if (isLoading) CircularProgressIndicator(
                    modifier = Modifier.size(
                        24.dp
                    )
                )
                else Text(text = "Login")
            }
            if (isAlertShown) {
                AlertDialog(

                    modifier = Modifier
                        .fillMaxWidth(),
                    onDismissRequest = { viewModel.hideAlert() },
                    text = {
                        Text(
                            text = "Go to next Screen?",
                            modifier = Modifier
                                .fillMaxWidth(),
                            textAlign = TextAlign.Center
                        )
                    },
                    buttons = {
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(15.dp),
                            horizontalArrangement = Arrangement.Center
                        ) {
                            Button(
                                modifier = Modifier
                                    .weight(1f),
                                onClick = {
                                    viewModel.hideAlert()
                                }) {
                                Text("No")
                            }
                            Spacer(modifier = Modifier.width(10.dp))
                            Button(
                                modifier = Modifier
                                    .weight(1f),
                                onClick = {
                                    coroutineScope.launch {
                                        viewModel.onShowNextScreen()
                                    }
                                }) {
                                Text("Yes")
                            }
                        }
                    }

                )
            }
        }
    }
}

@Preview
@Composable
fun DefaultPreview() {
    val model: LoginViewModel = viewModel()
//    MyApplicationTheme {
        LoginScreen(viewModel = model, onAction = {})
//    }
}